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
  
  def index
    user = User.find_by_id(params[:user_id])
    if user
      render json: BooksSerializer.new(user.all_books)
    else
      render json: { error: 'User could not be found.' }, status: 404
    end
  end

  def destroy
    user_id = params[:user_id]
    book_id = params[:id]

    record = UserBook.find_by(user_id: user_id, book_id: book_id)

    if record
      record.destroy
    else
      render json: { error: "Could not find record with user_id: #{user_id}, book_id: #{book_id}" }, status: 404
    end
  end
end
