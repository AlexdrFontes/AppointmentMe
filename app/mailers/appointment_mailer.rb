class AppointmentMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.appointment_mailer.Appointment.subject
  #
    default from: 'noreply@abc.com'
  def creation_confirmation(appointment)
    @appointment = appointment
    mail to: @appointment.email, subject: "You have created an appointment"
  end

  def reminder_email(appointment)
    @appointment = appointment
    mail to: @appointment.email, subject: "Reminder of your appointment"

  end
end
