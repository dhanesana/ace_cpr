# class UserNotifier < ApplicationMailer
# end
class UserNotifier < ActionMailer::Base
  default :from => ENV['GMAIL_EMAIL']

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_signup_email(user)
    @user = user
    @appointment = Appointment.where(id: @user.appointment_id).first
    mail(
      :to      => @user.email,
      :bcc     => "acecprsd@gmail.com",
      :subject => "Ace CPR SD Sign-Up Confirmation ##{@user.id}"
    )
  end
end
