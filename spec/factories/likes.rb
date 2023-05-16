FactoryBot.define do
  factory :like do
    association :liker, factory: :user
    association :likeable, factory: :video
    liked { Faker::Boolean.boolean }
    created_at { 1.day.ago }
  end
end
