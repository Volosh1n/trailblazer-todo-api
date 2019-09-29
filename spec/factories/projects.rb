FactoryBot.define do
  factory :project do
    name { FFaker::Lorem.words.join }
    user
  end
end
