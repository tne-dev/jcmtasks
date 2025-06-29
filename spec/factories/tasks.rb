FactoryBot.define do
  factory :task do
    association :user
    association :project
    title { Faker::Lorem.sentence(word_count: 2) }
    is_done { false }
    # if you need to attach a file, you can use fixture_file_upload in specs
  end
end
