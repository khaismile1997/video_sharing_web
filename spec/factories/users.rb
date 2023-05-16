FactoryBot.define do
  factory :user do
    username { Faker::Internet.username(specifier: 10) }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    session_token { SecureRandom::urlsafe_base64 }
  end
end
