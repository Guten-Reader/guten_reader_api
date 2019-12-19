FactoryBot.define do
  factory :user_book do
    user
    book
    current_page { 42 }
  end
end