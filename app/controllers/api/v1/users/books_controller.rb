class Api::V1::Users::BooksController < ApplicationController
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

  def update
    record = find_user_book(user_book_params)
    if record
      record.update(current_page: params[:current_page])
      render json: record
    end
  end

  private

  def find_user_book(params)
    UserBook.find_by(user_id: params[:user_id], book_id: params[:id])
  end

  def user_book_params
    params.permit(:user_id, :id)
  end
end