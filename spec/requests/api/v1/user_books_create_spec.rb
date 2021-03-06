require 'rails_helper'

describe "post user books" do
  it "can post user books" do

    user = create(:user)

    request_body = {
                      "guten_id": "12",
                      "title": "Through the Looking-Glass",
                      "author": "Carroll, Lewis",
                    }

    post "/api/v1/users/#{user.id}/books", as: :json, params: request_body

    new_book = Book.last
    user_book = UserBook.last

    expect(response).to have_http_status(201)

    expected_response = { message: "#{new_book.title} has been added to user: #{user_book.user_id}"}

    expect(response.body).to eq(expected_response.to_json)

    expect(new_book.guten_id).to eq(12)
    expect(new_book.author).to eq("Carroll, Lewis")
    expect(new_book.title).to eq("Through the Looking-Glass")
    expect(new_book.img_url).to eq(nil)

    expect(user_book.user_id).to eq(user.id)
    expect(user_book.book_id).to eq(new_book.id)
  end

  it "cannot post new book without proper body" do

    user = create(:user)

    request_body = {
                      "title": "Carroll, Lewis",
                      "author": "Through the Looking-Glass",
                    }

    post "/api/v1/users/#{user.id}/books", as: :json, params: request_body


    expect(response).to have_http_status(400)

    expected = {error: "Invalid request"}

    expect(response.body).to eq(expected.to_json)
  end

  it "cannot post user book if book already checked out" do

    user = create(:user)

    request_body = {
                      "guten_id": "12",
                      "title": "Through the Looking-Glass",
                      "author": "Carroll, Lewis",
                    }

    post "/api/v1/users/#{user.id}/books", as: :json, params: request_body
    expect(response).to have_http_status(201)

    post "/api/v1/users/#{user.id}/books", as: :json, params: request_body
    expect(response).to have_http_status(409)

    expected_response = { message: "User has already checked out book"}
    expect(response.body).to eq(expected_response.to_json)
  end
end
