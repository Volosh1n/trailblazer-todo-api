FactoryBot.define do
  factory :task do
    description { FFaker::Lorem.characters(200) }
    project
  end
end
