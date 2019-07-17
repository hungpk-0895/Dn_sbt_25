class BookingMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.booking_mailer.notification.subject
  #
  def notification user, tour
    @user = user
    @tour = tour
    mail to: user.email, subject: t(".subject")
  end
end
