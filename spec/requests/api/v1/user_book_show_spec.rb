require 'mock_helper'
require 'webmock/rspec'

describe 'GET /api/v1/users/:id/books/:id' do
  it 'returns paginated gutenberg book' do
    stub_alice_text

    user = create(:user)
    book_1 = create(:book, guten_id: 11)
    book_2 = create(:book, guten_id: 345)
    user_book1 = create(:user_book, user: user, book: book_1, current_page: 10)
    user_book2 = create(:user_book, user: user, book: book_2, current_page: 23)

    get "/api/v1/users/#{user.id}/books/#{book_1.id}"

    expect(response.status).to eq(200)

    data = JSON.parse(response.body, symbolize_names: true)

    expect(data).to have_key(:data)
    expect(data[:data]).to have_key(:current_page)
    expect(data[:data]).to have_key(:book)

    expect(data[:data][:current_page]).to equal(10)
    expect(data[:data][:book].count).to equal(278)

    first_page_text = "Project Gutenberg’s Alice’s Adventures in Wonderland, by Lewis Carroll\r\n\r\nThis eBook is for the use of anyone anywhere at no cost and with almost no restrictions whatsoever.  You may copy it, give it away or re-use it under the terms of the Project Gutenberg License included with this eBook or online at www.gutenberg.org\r\n\r\n\r\nTitle: Alice’s Adventures in Wonderland\r\n\r\nAuthor: Lewis Carroll\r\n\r\nPosting Date: June 25, 2008 [EBook #11] Release Date: March, 1994 Last Updated: October 6, 2016\r\n\r\nLanguage: English\r\n\r\nCharacter set encoding: UTF-8\r\n\r\n*** START OF THIS PROJECT GUTENBERG EBOOK ALICE’S"

    last_page_text = "start at our Web site which has the main PG search facility:\r\n\r\n     http://www.gutenberg.org\r\n\r\nThis Web site includes information about Project Gutenberg-tm, including how to make donations to the Project Gutenberg Literary Archive Foundation, how to help produce our new eBooks, and how to subscribe to our email newsletter to hear about new eBooks.\r\n"

    expect(data[:data][:book][0]).to eq(first_page_text)
    expect(data[:data][:book].last).to eq(last_page_text)

    data[:data][:book].each do |page|
      expect(page.length).to be < (625)
    end
  end

  it 'returns 404 if user not found' do
    get "/api/v1/users/1/books/13"

    expect(response.status).to eq(404)

    data = JSON.parse(response.body, symbolize_names: true)

    expected_error = {error: "Could not find record with user_id: 1, book_id: 13"}
    expect(data).to eq(expected_error)
  end
end
