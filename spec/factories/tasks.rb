FactoryBot.define do
  factory :task do
    description { FFaker::Lorem.paragraph }
    project
  end
end
