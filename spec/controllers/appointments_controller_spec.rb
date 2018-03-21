require 'rails_helper'

RSpec.describe AppointmentsController, type: :controller do
  describe 'POST /appointments' do

    it 'responds 201' do
      post :create, params: attributes_for(:appointment)
      expect(response.status).to eq(201)
    end

    it 'creates an appointment' do
      count = Appointment.count
      post :create, params: attributes_for(:appointment)
      new_count = Appointment.count

      expect(new_count-count).to eq(1)
    end

    it 'creates an User' do
      count = User.count
      post :create, params: attributes_for(:appointment)
      new_count = User.count
      expect(new_count-count).to eq(1)
    end
    it 'responds ID' do
      post :create, params: attributes_for(:appointment)
      json = JSON.parse(response.body)
      expect(json["id"]).not_to eq(nil)
    end

    it 'responds token' do
      post :create, params: attributes_for(:appointment)
      json = JSON.parse(response.body)
      expect(json["token"]).not_to eq(nil)
    end

    it 'User exists returns user token' do
      user = create(:user)

      post :create, params: attributes_for(:appointment, token: user.token)

      json = JSON.parse(response.body)
      expect(json["token"]).to eq(user.token)
    end

    it 'does not create a new user' do
      user = create(:user)
      new_count = User.count

      post :create, params: attributes_for(:appointment, token: user.token)

      count2 = User.count
      expect(new_count-count2).to eq(0)
    end

    it "sends an email after creation" do
      count = ActionMailer::Base.deliveries.count
      post :create, params: attributes_for(:appointment)
      new_count = ActionMailer::Base.deliveries.count
      expect(new_count - count).to eq(1)
    end
    it "enqueues a reminder job" do
      attributes = attributes_for(:appointment)
      expect {
        post :create, params: attributes
      }.to have_enqueued_job(AppointmentReminderJob)
    end
  end

  describe 'PATCH /appointments' do
    let(:appointment){ create(:appointment) }

    it 'updates name' do

      patch :update, params: {
        title: "lalala",
        id: appointment.id
      }
      expect(appointment.reload.title).to eq("lalala")
    end
    it 'responds with 200' do

      patch :update, params: {
        title: "lalala",
        id: appointment.id
      }
      expect(response.status).to eq(200)
    end
    it 'updates email' do
      patch :update, params: {
        email: "b@a.com",
        id: appointment.id
      }
      expect(appointment.reload.email).to eq("b@a.com")
    end
  end
  describe 'DELETE /appointments' do
    let(:appointment){ create(:appointment) }

    it 'responds status 200' do

      delete :destroy, params: {
        id: appointment.id
      }
      expect(response.status).to eq(200)
    end

    it 'deletes an appointment' do

      delete :destroy, params: {
        id: appointment.id
      }

      expect(Appointment.count).to eq(0)
    end
  end
end
