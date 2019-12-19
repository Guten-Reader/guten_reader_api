FactoryBot.define do
  factory :book do
    author { Faker::Book.author }
    title { Faker::Book.title }
    sequence(:guten_id) { |x| 100 + x }
    img_url { nil }
  end
end