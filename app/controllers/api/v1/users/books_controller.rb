class Api::V1::Users::BooksController < ApplicationController
  def index
    user = User.find_by_id(params[:user_id])
    if user
      render json: BooksSerializer.new(user.books)
    else
      render json: { error: 'User could not be found.' }, status: 404
    end
  end

  def destroy
    user_id = params[:user_id]
    book_id = params[:id]

    record = UserBook.find_by(user_id: user_id, book_id: book_id)
    # binding.pry
    if record
      record.destroy
    else
      render json: { error: "Could not find record with user_id: {user_id}, book_id: {book_id}" }, status: 404
    end
  end
end