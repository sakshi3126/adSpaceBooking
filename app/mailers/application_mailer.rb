class ApplicationMailer < ActionMailer::Base
  default from: 'notify.no-reply@outlook.com'
  layout 'mailer'
end
