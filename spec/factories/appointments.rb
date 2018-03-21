
FactoryBot.define do
  factory :appointment do
    association :user
    title 'fixo'
    email {Faker::Internet.email}
    appointment_date {Time.zone.now + 2.minutes}
    notification {appointment_date - 30.minutes}
  end
end
