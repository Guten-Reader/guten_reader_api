require 'rails_helper'

def stub_spotify_token
  body = File.open('./spec/fixtures/spotify_token.json')
  stub_request(:post, "https://accounts.spotify.com/api/token")
    .with(
      body: {
        "grant_type"=>"refresh_token",
        "refresh_token"=>"fake-refresh-token"
      },
      headers: {
        'Content-Type'=>'application/x-www-form-urlencoded',
      })
    .to_return(status: 200, body: body)
end

def stub_alice_text
  body = File.open('./spec/fixtures/alice.json')
  stub_request(:get, "https://gutenberg.justamouse.com/texts/11/body")
    .to_return(status: 200, body: body)
end
