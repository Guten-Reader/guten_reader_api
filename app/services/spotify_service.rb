class SpotifyService

  def get_access_token(user)
    response = conn.post('/token') do |request|
      request.headers['Content-Type'] = 'application/x-www-form-urlencoded'
      request.headers['Authorization'] = "#{ENV['SPOTIFY_APP_API_KEY']}"
      request.body = {grant_type: "refresh_token",
                      refresh_token: "#{user.refresh_token}"}.to_json
    end
    parsed_data = JSON.parse(response.body, symbolize_names: true)
    parsed_data[:access_token]
  end

  private
  def conn
    Faraday.new(
        url: 'https://accounts.spotify.com/api'
      )
  end
end
