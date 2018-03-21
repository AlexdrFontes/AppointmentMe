
FactoryBot.define do
  factory :user do
    token {Faker::Internet.password(10, 20)}
  end
end
