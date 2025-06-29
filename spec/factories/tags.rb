FactoryBot.define do
  factory :tag do
    association :user
    title { Faker::Lorem.unique.word }
  end
end
