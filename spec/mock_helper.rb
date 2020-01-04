require 'rails_helper'

def stub_alice_text
  body = File.open('./spec/fixtures/alice.json')
  stub_request(:get, "https://gutenberg.justamouse.com/texts/11/body")
    .to_return(status: 200, body: body)
end