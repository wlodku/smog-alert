class UserMailer < ApplicationMailer
  helper MailerHelper
  default from: Setting.smtp_login
  layout 'mailer'

  def alert(user, measurements)
    delivery_options = {
                         user_name: Setting.smtp_login,
                         password: Setting.smtp_password,
                         address: Setting.smtp_host
                       }
    @om = measurements
    @delay = user.delay
    mail(to: user.email,
        subject: "Uwaga na smog",
        delivery_method_options: delivery_options)
  end



end
