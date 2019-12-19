FactoryBot.define do
  factory :user do
    username { Faker::Name.name }
    email { Faker::Internet.email }
    password_digest { 'password' }
    spotify_token { nil }
    role { 0 }
  end
end