class UserMailer < ActionMailer::Base
  default from: 'no-reply@recstream.co'
  layout 'mailer'
end
