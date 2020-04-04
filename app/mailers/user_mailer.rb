class UserMailer < ApplicationMailer
  # default from: 'notify.no-reply@outlook.com'

  def notification_email(user, slot=false, bid = false)
    @user = user
    @slot = slot
    @bid = bid
    mail(to:@user.email, subject: 'Confirmation Mail from MyAdvertisementPortal')
  end
  def sent_for_approval(user, bid)
    @user= user
    @bid = bid
    mail(to:@user.email, subject: 'Confirmation Mail from MyAdvertisementPortal')
  end
end
