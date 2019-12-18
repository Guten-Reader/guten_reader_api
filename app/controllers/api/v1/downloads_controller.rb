class Api::V1::DownloadsController < ApplicationController
  def index
    render json: { message: 'Hello' }
  end
end