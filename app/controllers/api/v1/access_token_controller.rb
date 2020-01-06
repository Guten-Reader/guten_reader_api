class Api::V1::AccessTokenController < ApplicationController

  def show
    binding.pry
    # return cannot_find_user(params['id']) unless @user
    # 
    # access_token = SpotifyService.new.get_access_token(@user.refresh_token)
    # render json: {access_token: access_token }, status: 200
  end

 private
  def cannot_find_user(params)
    render json: {
      error: "Could not find record with user_id: #{params[:user_id]}"
    }, status: 404
  end

  def find_user_book
    params = user_params
    @user ||= User.find_by(
      user_id: user_params[:id])
  end

  def user_params
    params.permit(:id)
  end
end
