FactoryBot.define do
  factory :task do
    name { FFaker::Lorem.word.upcase }
    description { FFaker::Lorem.sentence }
    estimate_date { Date.today + rand(10_000) }
    price { rand(10.0...90.0).round(2) }
    status { %w[initialized processing failed finished].sample }
    progress { rand(100) }
    association :project
  end
end
