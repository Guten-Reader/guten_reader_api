require 'rails_helper'

describe 'GET /api/v1/users/:id/books' do
  it 'returns an empty array if User has no books' do
    user = create(:user)

    get "/api/v1/users/#{user.id}/books"

    expect(response.status).to eq(200)

    data = JSON.parse(response.body, symbolize_names: true)

    expect(data).to eq({ books: [] })
  end

  it 'returns an array of books if user has books' do
    user, book1, book2 = create(:user), create(:book), create(:book)
    user_book1 = create(:user_book, user: user, book: book1, current_page: 25)
    user_book2 = create(:user_book, user: user, book: book2, current_page: 10)

    get "/api/v1/users/#{user.id}/books"

    expect(response.status).to eq(200)

    data = JSON.parse(response.body, symbolize_names: true)

    expected = {
      books: [
        {
          id: book1.id,
          guten_id: book1.guten_id,
          title: book1.title,
          author: book1.author,
          current_page: user_book1.current_page
        },
        {
          id: book2.id,
          guten_id: book2.guten_id,
          title: book2.title,
          author: book2.author,
          current_page: user_book2.current_page
        }
      ]
    }

    expect(data).to eq(expected)
  end

  it 'returns 404 if user not found' do
    get "/api/v1/users/1/books"
    
    expect(response.status).to eq(404)

    data = JSON.parse(response.body, symbolize_names: true)

    expect(data).to eq({ error: 'User could not be found.' })
  end
end