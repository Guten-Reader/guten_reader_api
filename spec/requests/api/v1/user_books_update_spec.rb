require 'rails_helper'

describe 'PATCH /api/v1/users/:user_id/books/:book_id' do
  it 'updates the current page of a user_book' do
    user, book = create(:user), create(:book)
    user_book = create(:user_book, user: user, book: book, current_page: 10)

    expect(user_book.current_page).to eq(10)

    patch "/api/v1/users/#{user.id}/books/#{book.id}?current_page=11"

    data = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(200)
    expect(data[:user_id]).to eq(user_book.user_id)
    expect(data[:book_id]).to eq(user_book.book_id)
    expect(data[:current_page]).to eq(11)
  end

  it 'returns 400 if missing query param current_page' do 
    patch "/api/v1/users/#{user.id}/books/#{book.id}"

    data = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(400)
    expect(data).to eq({ error: "Missing query param current_page" })
  end
end