require 'rails_helper'

describe 'DELETE /api/v1/users/:user_id/books/:book_id' do
  it 'removes a record from the user_books table' do 
    user, book1, book2 = create(:user), create(:book), create(:book)
    user_book1 = create(:user_book, user: user, book: book1)
    user_book2 = create(:user_book, user: user, book: book2)

    expect(user.books.length).to eq(2)

    delete "/api/v1/users/#{user.id}/books/#{book1.id}"

    expect(response.status).to eq(204)
    expect(response.body).to eq('')

    user.reload
    expect(user.books.length).to eq(1)
    expect(user.books.first).to eq(book2)
  end

  it 'returns 404 if record not found' do
    delete "/api/v1/users/1/books/1"

    message = JSON.parse(response.body)

    expect(response.status).to eq(404)
    expect(message).to eq({ 'error'=> 'Could not find record with user_id: 1, book_id: 1' })
  end

  describe 'edge case: users have same book' do
    it 'only deletes the book for a specific user' do
      user1, user2 = create(:user), create(:user)
      book1, book2 = create(:book), create(:book)
      create(:user_book, user: user1, book: book1)
      create(:user_book, user: user1, book: book2)
      create(:user_book, user: user2, book: book1)
      create(:user_book, user: user2, book: book2)

      delete "/api/v1/users/#{user1.id}/books/#{book1.id}"

      user1.reload

      expect(user1.books.length).to eq(1)
      expect(user2.books.length).to eq(2)
    end
  end
end