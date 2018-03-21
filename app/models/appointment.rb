class Appointment < ApplicationRecord
  belongs_to :user, primary_key: "token", foreign_key: "token"
  validates_presence_of :title, :appointment_date, :notification
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validate :notification_before_appointment
  validate :appointment_date_before_present_time

  def notification_before_appointment
    if notification.nil? || appointment_date.nil?
      return true
    end
    if notification > appointment_date
      errors.add(:notification, :invalid_date, message: "date must be before appointment_date")
      return false
    else
      return true
    end
  end
  def appointment_date_before_present_time
    if appointment_date.nil?
      return true
    end
    if  appointment_date < Time.now
      errors.add(:appointment_date, :invalid_date, message: "date must be after current date")
      return false
    else
      return true
    end

  end
end
