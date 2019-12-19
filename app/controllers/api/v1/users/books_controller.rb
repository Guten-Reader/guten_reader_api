class Api::V1::Users::BooksController < ApplicationController
  def create
    book = Book.where(book_params).first_or_create
    user_book = UserBook.where(book_id: book.id, user_id: params['user_id']).first_or_create
    if book && user_book
      render json: { message: "#{book.title} has been added to user: #{user_book.user_id}"}, status: 201
    end
  end

  private

  def book_params
    { guten_id: params['guten_id'].to_i,
      title: params['title'],
      author: params['author'] }
  end
end
