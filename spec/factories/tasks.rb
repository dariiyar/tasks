FactoryBot.define do
  factory :task do
    name { FFaker::Lorem.word.upcase }
    description { FFaker::Lorem.sentence }
    estimate_date { Date.today + rand(10_000) }
    project
  end
end
