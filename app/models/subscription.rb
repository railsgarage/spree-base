class Subscription < ActiveRecord::Base
  attr_accessible :membership_id, :user_id, :user, :name, :notes, :card_token, :stripe_subscription_id, :status

  belongs_to :membership
  belongs_to :user

  validates :name, presence: true

  def process
    user = self.user
    membership = self.membership
    account = membership.account
    begin
      customer = create_customer(user, account)
      create_subscription(customer, membership, account)
      true
    rescue Stripe::CardError => e
      self.errors.add(:stripe, e.message)
      false
    rescue => e
      logger.info '=========== Payment Error ================'
      logger.info e
      logger.info '=========== Payment Error ================'
      self.errors.add(:stripe, 'Something happened while we were subscribing you. We have been notified of this and we will fix it as soon as possible. Please try again soon.')
      false
    end
  end

  def create_customer(user, account)
    customer = Stripe::Customer.create({
      email: user.email,
      description: "Subscription: #{self.name}",
      card: self.card_token
    }, account.stripe_token)
    self.update_attribute(:stripe_customer_id, customer['id'])
    customer
  end

  def create_subscription(customer, membership, account)
    subscription = customer.subscriptions.create({
      plan: membership.id.to_s
    }, account.stripe_token)
    self.update_attributes(stripe_subscription_id: subscription['id'], status: subscription['status'])
  end

  def cancel
    account = self.membership.account
    begin
      customer = Stripe::Customer.retrieve(self.stripe_customer_id, account.stripe_token)
      customer.subscriptions.retrieve(self.stripe_subscription_id, account.stripe_token).delete
    rescue => e
      logger.info '=========== Cancel Subscription Error ================'
      logger.info e
      logger.info '=========== Cancel Subscription Error ================'
      self.errors.add(:stripe, e)
      false
    end
  end

  def update_from_webhook(subscription)
    self.update_attributes({
      status: subscription.status
    })
  end

  def active?
    self.status == 'active'
  end

end
