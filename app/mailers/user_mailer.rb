class UserMailer < ApplicationMailer
  # default from: 'notify.no-reply@outlook.com'

  def notification_email(user)
    @user = user
    mail(to:@user.email, subject: 'Welcome to My Awesome Site')
  end
end
