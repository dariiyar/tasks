FactoryBot.define do
  factory :task do
    project
    name { FFaker::Lorem.word.upcase }
    description { FFaker::Lorem.sentence }
    estimate_date { Date.today + rand(100) }
    price { rand(10.0...90.0).round(2) }
    status { rand(3) }
    progress { rand(100) }
  end
end
