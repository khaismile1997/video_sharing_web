FactoryBot.define do
  factory :video do
    youtube_video_id { Faker::Alphanumeric.alphanumeric(number: 11) }
    title { Faker::Hipster.sentences.sample }
    description { Faker::Lorem.characters }
    association :sharer, factory: :user

    after(:create) do |video|
      create_list(:like, 3, likeable: video)
    end
  end
end
