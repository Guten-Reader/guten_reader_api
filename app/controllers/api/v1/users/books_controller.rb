class Api::V1::Users::BooksController < ApplicationController
  def index
    user = User.find(params[:user_id])
    render json: BooksSerializer.new(user.books)
  end
end