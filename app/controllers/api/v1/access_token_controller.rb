class Api::V1::AccessTokenController < ApplicationController
before_action :find_user, only: [:show]
  def show
    return cannot_find_user(params[:id]) unless @user
    access_token = SpotifyService.new.get_access_token(@user)
    render json: {access_token: access_token }, status: 200
  end

 private
  def cannot_find_user(id)
    render json: {
      error: "Could not find record with user_id: #{id}"
    }, status: 404
  end

  def find_user
    params = user_params
    @user ||= User.find_by(id: user_params[:id])
  end

  def user_params
    params.permit(:id)
  end
end
