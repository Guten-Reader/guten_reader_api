require 'rails_helper'

describe 'GET /api/v1/users/:id/books' do
  it 'returns an empty array if User has no books' do
    user = create(:user)

    get "/api/v1/users/#{user.id}/books"

    expect(response).to be_successful

    data = JSON.parse(response.body, symbolize_names: true)

    expect(data).to eq({ books: [] })
  end
end