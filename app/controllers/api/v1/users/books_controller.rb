class Api::V1::Users::BooksController < ApplicationController
  before_action :find_user_book, only: [:destroy, :update, :show]

  def show
    if @user_book.nil?
      return cannot_find_user_book(params)
    end
    guten_id = @user_book.book.guten_id
    paginated_book = PaginateFacade.new.get_paginated_book(@user_book, guten_id)
    render json: {data: paginated_book }
  end

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
    if @user_book
      @user_book.destroy
    else
      return cannot_find_user_book(params)
    end
  end

  def update
    unless params[:current_page]
      return render json: { error: "Missing query param current_page" }, status: 400
    end

    if @user_book
      @user_book.update(current_page: params[:current_page])
      render json: @user_book
    else
      return cannot_find_user_book(params)
    end
  end

 private
  def cannot_find_user_book(params)
    render json: {
      error: "Could not find record with " \
             "user_id: #{params[:user_id]}, " \
             "book_id: #{params[:id]}"
    }, status: 404
  end

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
