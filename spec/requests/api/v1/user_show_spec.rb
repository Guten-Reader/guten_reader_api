require 'rails_helper'

describe 'GET /api/v1/users/:user_id' do
  it 'returns user setting preference' do
    user = create(:user,
                  username: "Mack",
                  music_genre: "piano",
                  dyslexic_font: false,
                  dark_mode: true,
                  font_size: 20)

    get "/api/v1/users/#{user.id}"
    data = JSON.parse(response.body, symbolize_names: true)

    patched_user = User.last

    expect(response).to have_http_status(200)
    expect(data[:id]).to eq(user.id)
    expect(data[:username]).to eq("Mack")
    expect(data[:music_genre]).to eq("piano")
    expect(data[:dyslexic_font]).to eq(false)
    expect(data[:dark_mode]).to eq(true)
    expect(data[:font_size]).to eq(20)
  end

  it 'returns 404 if user not found' do
    user = create(:user)

    get "/api/v1/users/1000"

    data = JSON.parse(response.body, symbolize_names: true)

    expect(response).to have_http_status(404)
    expect(data).to eq({error: "Could not find user with user_id: 1000"})
  end
end
