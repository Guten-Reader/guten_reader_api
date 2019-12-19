require 'rails_helper'

describe 'DELETE /api/v1/users/:user_id/books/:book_id' do
  it 'removes a record from the user_books table' do 
    user, book1, book2 = create(:user), create(:book), create(:book)
    user_book1 = create(:user_book, user: user, book: book1)
    user_book2 = create(:user_book, user: user, book: book2)

    expect(user.books.length).to eq(2)

    delete "/api/v1/users/#{user.id}/books/#{book1.id}"
    
    expect(response.status).to eq(204)
    # expect(user.books.length).to eq(1)
    expect(user.books.first).to eq(book2)
  end
end