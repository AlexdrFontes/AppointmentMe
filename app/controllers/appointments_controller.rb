class AppointmentsController < ApplicationController

  def create
    @appointment = Appointment.new(title: params[:title],
      email: params[:email], notification: params[:notification],
      appointment_date: params[:appointment_date], user: User.new(token: generate_token))

    user = User.find_by(token: params[:token])
    if !user.nil?
      @appointment.user = user
    end

    if @appointment.save
      AppointmentReminderJob.set(wait_until: @appointment.notification.to_f).perform_later(@appointment)
      AppointmentMailer.creation_confirmation(@appointment).deliver_now
      render status: 201, json: {id: @appointment.id, token: @appointment.token}
    else
      render status: 422, json: @appointment.errors.messages
    end
  end

  def update
    @appointment = Appointment.find(params[:id])
    if @appointment.update(appointment_params)
      render status: 200, json: {id: @appointment.id, token: @appointment.token}
    else
      render status: 422, json: @appointment.errors.messages
    end
  end

  def generate_token
    loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless User.exists?(token: random_token)
    end
  end

  def destroy
    @appointment = Appointment.find(params[:id])
    @appointment.destroy
    render status: 200, json: {id: @appointment.id}
  end

  def appointment_params
    params.permit(:title, :email)
  end
end

