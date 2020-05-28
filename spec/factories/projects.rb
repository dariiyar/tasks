FactoryBot.define do
  factory :project do
    name { FFaker::Lorem.word.upcase }
    description { FFaker::Lorem.sentence }
    price { rand(1000.2...10_000.9).round(2) }
    factory :project_with_tasks do
      transient do
        tasks_count { 5 }
      end
      after(:create) do |project, evaluator|
        create_list(:task, evaluator.tasks_count, project: project)
      end
    end
  end
end
