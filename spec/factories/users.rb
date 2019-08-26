FactoryBot.define do
  factory :user do
    email { FFaker::Internet.safe_email }
    password { SecureRandom.hex }
    password_confirmation { password }
  end
end
