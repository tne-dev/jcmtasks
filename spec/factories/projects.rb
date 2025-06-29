FactoryBot.define do
  factory :project do
    association :user
    title { Faker::App.name }
    position { nil }
  end
end
