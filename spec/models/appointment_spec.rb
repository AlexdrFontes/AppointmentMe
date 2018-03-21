require 'rails_helper'

RSpec.describe Appointment, type: :model do
  it { should validate_presence_of(:title) }
  # it { should validate_presence_of(:email) }

  describe "when email is not present" do
    before { email = " " }
    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                  foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        email = invalid_address
        should_not be_valid
      end
    end
  end

  describe "Notification validity" do
    context "When notification is before appointment_date" do
      let(:appointment) { build(:appointment, notification: Time.now, appointment_date: Time.now + 30.minutes) }
      it "is valid" do
        appointment.valid?
        expect(appointment.errors.messages[:notification]).to be_empty
      end
    end
    context "When notification is after appointment_date" do
      let(:appointment) { build(:appointment, notification: Time.now, appointment_date: Time.now - 30.minutes) }
      it "is invalid" do
        appointment.valid?
        expect(appointment.errors.messages[:notification]).not_to be_empty
      end
    end
  end
  describe "Appointment date validity" do
    context "When appointment date is before current time" do
      let(:appointment) { build(:appointment, appointment_date: Time.now - 30.minutes) }
      it "is invalid" do
        appointment.valid?
        expect(appointment.errors.messages[:appointment_date]).not_to be_empty
      end
    end
    context "When appointment date is after current time" do
      let(:appointment) { build(:appointment, appointment_date: Time.now + 30.minutes) }
      it "is valid" do
        appointment.valid?
        expect(appointment.errors.messages[:notification]).to be_empty
      end
    end
  end

  it { should validate_presence_of(:appointment_date) }
  it { should validate_presence_of(:notification) }
end
