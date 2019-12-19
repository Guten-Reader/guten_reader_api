class Api::V1::Users::BooksController < ApplicationController
  def create
    facade = UserBooksFacade.new(params)
    book = facade.can_create_or_add_book?

    unless book.id?
      return render json: { error: "Invalid request"},  status: 400
    end

    user_book = facade.checkout_book(book)
    if user_book
        render json: { message: "#{user_book.book.title} has been added to user: #{user_book.user_id}"}, status: 201
    else
      render json: { message: "User has already checked out book"}, status: 409
    end
  end
end
