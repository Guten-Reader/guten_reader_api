class JestamouseService

  def get_book_text(guten_id)
    json_response = conn.get("/texts/#{guten_id}/body")
    parsed_data = JSON.parse(json_response.body, symbolize_names: true)
  end

  private
  def conn
    Faraday.new(
        url: 'https://gutenberg.justamouse.com/'
      )
  end
end
