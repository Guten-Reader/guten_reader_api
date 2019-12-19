require 'rails_helper'

describe 'GET /api/v1/users/:id/books' do
  it 'returns an empty array if User has no books' do
    user = create(:user)

    get "/api/v1/users/#{user.id}/books"

    expect(response).to be_successful

    data = JSON.parse(response.body, symbolize_names: true)

    expect(data).to eq({ books: [] })
  end

  it 'returns an array of books if user has books' do
    user, book1, book2 = create(:user), create(:book), create(:book)
    user_book1 = create(:user_book, user: user, book: book1)
    user_book2 = create(:user_book, user: user, book: book2)

    get "/api/v1/users/#{user.id}/books"

    expect(response).to be_successful

    data = JSON.parse(response.body, symbolize_names: true)

    expected = {
      books: [
        {
          id: book1.id,
          guten_id: book1.guten_id,
          title: book1.title,
          author: book1.author
        },
        {
          id: book2.id,
          guten_id: book2.guten_id,
          title: book2.title,
          author: book2.author
        }
      ]
    }

    expect(data).to eq(expected)
  end
end