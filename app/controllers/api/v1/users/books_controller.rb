class Api::V1::Users::BooksController < ApplicationController
  before_action :find_user_book, only: [:destroy, :update]

  def index
    user = User.find_by_id(params[:user_id])
    if user
      render json: BooksSerializer.new(user.all_books)
    else
      render json: { error: 'User could not be found.' }, status: 404
    end
  end

  def destroy
    if @user_book
      @user_book.destroy
    else
      render json: {
        error: "Could not find record with " \
               "user_id: #{params[:user_id]}, " \
               "book_id: #{params[:id]}"
      }, status: 404
    end
  end

  def update
    unless params[:current_page]
      render json: { error: "Missing query param current_page" }, status: 400
    end

    if @user_book
      @user_book.update(current_page: params[:current_page])
      render json: @user_book
    end
  end

  private

  def find_user_book
    params = user_book_params
    @user_book ||= UserBook.find_by(
      user_id: params[:user_id],
      book_id: params[:id])
  end

  def user_book_params
    params.permit(:user_id, :id)
  end
end