class User < ActiveRecord::Base
  attr_accessor :updating_password, :creating_user
  attr_accessible :admin, :god, :email, :password, :first_name, :last_name, :street, :city, :state, :zip, :phone, :account_id

  authenticates_with_sorcery!

  belongs_to :account

  has_many :registrations
  has_many :activities, through: :registrations

  has_many :subscriptions
  has_many :memberships, through: :subscriptions

  has_many :reservations
  has_many :events, through: :reservations

  has_many :authentications

  validates :email, presence: true
  validates :password, presence: true, if: :validate_password?
  validates :first_name, presence: true
  validates :last_name, presence: true

  # figure out where these are needed and handle setting them then
  # validates :city, presence: true
  # validates :state, presence: true
  # validates :zip, presence: true
  # validates :phone, presence: true

  def validate_password?
    self.updating_password || self.creating_user
  end

  def name
    "#{self.first_name} #{self.last_name}"
  end

  def is_not_registered_for(activity)
    !self.activities.include?(activity)
  end

  def is_registered_for(activity)
    self.activities.include?(activity)
  end

  def self.find_or_create_by_auth_hash(hash, account)
    auth = Authentication.find_by_uid_and_provider(hash['uid'], hash['provider'])
    if auth
      auth.user
    else
      info = hash['info']
      user = self.create!({
        email: (info['email'] || 'Update Email'),
        first_name: (info['first_name'] || info['name'].split(' ')[0]),
        last_name: (info['last_name'] || info['name'].split(' ')[1]),
        account_id: account.id
      })
      user.authentications.create({
        uid: hash['uid'],
        provider: hash['provider']
      })
      user
    end
  end

end
