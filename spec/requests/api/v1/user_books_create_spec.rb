require 'rails_helper'

describe "post user books" do
  it "can post user books" do

    @user = create(:user)

    request_body = {
                      "guten_id": "123453",
                      "title": "example title",
                      "author": "example author",
                    }

    post "/api/v1/users/#{@user.id}/books", as: :json, params: request_body


    expect(user.email).to eq("whatever@example.com")
    expect(user.password_digest).to_not eq(nil)

    expect(response).to have_http_status(201)

    expected_response = {"api_key": user.token}

    expect(response.body).to eq(expected_response.to_json)
  end

  # it "cannot create account with email" do
  #
  #   request_body = {
  #                   "email": "bad_email",
  #                   "password": "password",
  #                   "password_confirmation": "password"
  #                   }
  #
  #   post "/api/v1/users", as: :json, params: request_body
  #
  #   expect(response).to have_http_status(400)
  #   expected = {error: "Email is invalid"}
  #
  #   expect(response.body).to eq(expected.to_json)
  # end
  #
  # it "cannot create account if passwords do not match" do
  #
  #   request_body = {
  #                   "email": "whatever@example.com",
  #                   "password": "password",
  #                   "password_confirmation": "bad_password"
  #                   }
  #
  #   post "/api/v1/users", as: :json, params: request_body
  #
  #   expect(response).to have_http_status(400)
  #   expected = {error: "Password confirmation doesn't match Password and Password confirmation doesn't match Password"}
  #
  #   expect(response.body).to eq(expected.to_json)
  end
end
