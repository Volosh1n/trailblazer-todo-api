FactoryBot.define do
  factory :user do
    email { Faker::Internet.safe_email }
    password_digest { SecureRandom.hex }
  end
end
