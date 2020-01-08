require 'mock_helper'

describe 'SpotifyService' do
  it 'can return access token from Spotify API' do
    stub_spotify_token
    
    service = SpotifyService.new
    user = create(:user, refresh_token: 'fake-refresh-token')
    token = service.get_access_token(user)
    expect(token).to eq('this-is-a-fake-access-token')
  end
end