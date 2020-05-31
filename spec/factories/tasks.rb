FactoryBot.define do
  factory :task do
    project
    name { FFaker::Lorem.word.upcase }
    description { FFaker::Lorem.sentence }
    estimate_date { rand(1..100).days.from_now }
    price { rand(10.0...90.0).round(2) }
    status { rand(3) }
    urls { [FFaker::Internet.http_url] }
    progress { rand(100) }
  end
end
