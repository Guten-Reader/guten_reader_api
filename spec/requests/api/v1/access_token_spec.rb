require 'mock_helper'

describe 'GET /api/v1/access_token/:id' do
  it 'returns new access_token for specific user' do
    stub_spotify_token

    user_1 = create(:user, id: 1, refresh_token: 'fake-refresh-token')
    user_2 = create(:user, id: 2, refresh_token: "12345")

    get "/api/v1/access_token/#{user_1.id}"

    expect(response.status).to eq(200)

    data = JSON.parse(response.body, symbolize_names: true)

    expect(data).to have_key(:access_token)
    expect(data[:access_token]).to eq('this-is-a-fake-access-token')
  end

  it 'returns 404 if user not found' do

    get "/api/v1/access_token/1000"

    expect(response.status).to eq(404)

    data = JSON.parse(response.body, symbolize_names: true)

    expected_error = {error: "Could not find record with user_id: 1000"}
    expect(data).to eq(expected_error)
  end
end
