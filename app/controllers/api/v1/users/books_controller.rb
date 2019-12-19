class Api::V1::Users::BooksController < ApplicationController
  def index
    user = User.find_by_id(params[:user_id])
    if user
      render json: BooksSerializer.new(user.books)
    else
      render json: { error: 'User could not be found.' }, status: 404
    end
  end
end