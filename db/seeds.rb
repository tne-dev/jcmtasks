# db/seeds.rb
require 'faker'

puts "Starting seed process..."

# Vytvoření admin uživatele pro UAT testování
super_admin = User.find_or_create_by(email: 'sa@uat.com') do |user|
  user.password = 'Password123'
  user.password_confirmation = 'Password123'
  user.first_name = 'SA'
  user.last_name = 'Test'
end

# Vytvoření běžných testovacích uživatelů
test_users = []
5.times do |i|
  user = User.find_or_create_by(email: "user-#{i+1}@uat.com") do |u|
    u.password = 'Password123'
    u.password_confirmation = 'Password123'
    u.first_name = Faker::Name.first_name
    u.last_name = Faker::Name.last_name
  end
  test_users << user
end

puts "Created #{User.count} users"

# Vytvoří uživatelská data
test_users.each do |user|
  3.times do |i|
    project = user.projects.find_or_create_by(title: "#{Faker::Company.buzzword} Project #{i+1}") do |p|
      p.position = i + 1
    end

    tags = []
    5.times do |j|
      tag = user.tags.find_or_create_by(title: Faker::Hacker.noun.capitalize) do |t|

      end
      tags << tag
    end

    rand(3..8).times do |k|
      # Use proper Faker methods
      task_title = "#{Faker::Lorem.word.capitalize} #{Faker::Lorem.word}"

      task = user.tasks.find_or_create_by(title: task_title) do |t|
        t.description = Faker::Lorem.paragraph(sentence_count: rand(2..5))
        t.is_done = [true, false].sample
        t.project = rand < 0.8 ? project : nil
      end

      task.tags = tags.sample(rand(0..3))
    end
  end

  rand(2..5).times do
    task_title = "Personal task: #{Faker::Lorem.words(number: 3).join(' ').capitalize}"

    task = user.tasks.find_or_create_by(title: task_title) do |t|
      t.description = Faker::Lorem.paragraph(sentence_count: rand(1..3))
      t.is_done = [true, false].sample
    end

    task.tags = user.tags.sample(rand(0..2))
  end
end

puts "Created #{Project.count} projects"
puts "Created #{Tag.count} tags"
puts "Created #{Task.count} tasks"
puts "Seed process completed successfully!"
