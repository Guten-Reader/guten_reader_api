require 'rails_helper'

describe 'PATCH /api/v1/users/:user_id' do
  it 'updates a user setting preference' do
    user = create(:user)

    request_body = {
                      "music_genre": "piano",
                      "dyslexic_font": true,
                      "dark_mode": false,
                      "font_size": 10
                    }

    patch "/api/v1/users/#{user.id}", as: :json, params: request_body

    patched_user = User.last

    expect(response).to have_http_status(204)
    expect(patched_user.music_genre).to eq("piano")
    expect(patched_user.dyslexic_font).to eq(true)
    expect(patched_user.dark_mode).to eq(false)
    expect(patched_user.font_size).to eq(10)
  end

  it 'returns 400 if missing required body params' do
    user = create(:user)

    request_body = {
                      "music_genre": "piano",
                      "dyslexic_font": true,
                      "font_size": 10
                    }

    patch "/api/v1/users/#{user.id}", as: :json, params: request_body

    data = JSON.parse(response.body, symbolize_names: true)

    expect(response).to have_http_status(400)
    expect(data).to eq({ "error": "The following body params are missing: dark_mode" })

    request_body = {
                      "music_genre": "piano",
                      "dyslexic_font": true
                    }

    patch "/api/v1/users/#{user.id}", as: :json, params: request_body

    data = JSON.parse(response.body, symbolize_names: true)

    expect(response).to have_http_status(400)
    expect(data).to eq({ "error": "The following body params are missing: dark_mode and font_size" })
  end

  it 'returns 404 if user not found' do
    user = create(:user)

    request_body = {
                      "music_genre": "piano",
                      "dyslexic_font": true,
                      "dark_mode": false,
                      "font_size": 10
                    }

    patch "/api/v1/users/1000", as: :json, params: request_body

    data = JSON.parse(response.body, symbolize_names: true)

    expect(response).to have_http_status(404)
    expect(data).to eq({error: "Could not find user with user_id: 1000"})
  end
end
