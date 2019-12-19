class Api::V1::Users::BooksController < ApplicationController
  def create
    facade.validate_params(params)
    # book = Book.find_or_create_book(book_params)
    # user_book = UserBook.create_user_book(book.id, user_id)
  end
end
