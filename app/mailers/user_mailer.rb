class UserMailer < ActionMailer::Base
  default from: CONFIG[:from_email]

  def welcome_email(user)
    @user = user
    mail(to: user.email, subject: "Welcome to Library")
  end

  def reservation_confirmation(reservation)
    @reservation = reservation
    mail(to: reservation.user.email, subject: "#{@reservation.book.title} book reservation")
  end
end
