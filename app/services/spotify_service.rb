class SpotifyService

  def get_access_token(user)
    response = conn.post('/api/token') do |request|
      request.headers['Content-Type'] = 'application/x-www-form-urlencoded'
      request.headers['Authorization'] = "#{ENV['SPOTIFY_APP_API_KEY']}"
      request.body = URI.encode_www_form({grant_type: "refresh_token",
                      refresh_token: "#{user.refresh_token}"})
    end
    parsed_data = JSON.parse(response.body, symbolize_names: true)
    parsed_data[:access_token]
  end

  private
  def conn
    Faraday.new(
        url: 'https://accounts.spotify.com'
      )
  end
end
