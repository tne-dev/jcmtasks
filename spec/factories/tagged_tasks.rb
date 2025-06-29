FactoryBot.define do
  factory :tagged_task do
    association :task
    association :tag
  end
end