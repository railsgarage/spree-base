class RegistrationMailer < ActionMailer::Base
  default from: 'no-reply@recstream.co'
  layout 'mailer'

  def register
    mail to: 'thogg4@gmail.com', subject: "Registration"
  end

  def email_schedule(user, activity, schedule)
    @user = user
    @account = @user.account
    @activity = activity
    attachments["#{activity.cached_slug}-schedule.pdf"] = { mime_type: 'application/pdf', content: schedule }
    mail to: @user.email, subject: "Schedule for #{@activity.name}"
  end

end
