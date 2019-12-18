class Api::V1::DownloadsController < ApplicationController
  def index
    Faraday.get("")
    render json: { message: 'Hello' }
  end
end