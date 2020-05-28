FactoryBot.define do
  factory :project do
    name { FFaker::Lorem.word.upcase }
    description { FFaker::Lorem.sentence }
    price { rand(100.2...1000.9).round(2) }
  end
end
