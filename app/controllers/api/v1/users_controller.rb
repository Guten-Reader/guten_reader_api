class Api::V1::UsersController < ApplicationController
  before_action :find_user, only: [:update]

  def update
    unless missing_params.empty?
      return error_missing_params(missing_params)
    end

    if @user
      @user.update_settings(params)
      render status: 204
    else
      return error_cannot_find_user
    end
  end

 private

  def error_missing_params(params_missing)
     render json: {
       error: "The following body params " \
              "are missing: #{params_missing}"
       }, status: 400
  end

  def error_cannot_find_user
    render json: {
      error: "Could not find user with " \
             "user_id: #{params[:id]}"
    }, status: 404
  end

  def find_user
    @user ||= User.find_by(id: params[:id])
  end

  def missing_params
    require_params = ["music_genre", "dyslexic_font", "dark_mode", "font_size"]
    missing = require_params - user_params.keys
    missing.to_sentence
  end

  def user_params
    params.permit(:music_genre, :dyslexic_font, :dark_mode, :font_size)
  end
end
