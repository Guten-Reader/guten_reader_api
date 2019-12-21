require 'epub/parser'

class ParserFacade
  def initialize()
  end

  def get_parsed_book(user_book, full_text)
    {
      current_page: user_book.current_page,
      book: parse_data(full_text)
    }
  end

  def parse_data(full_text)
    clean_data = full_text[:body].gsub(/(\S)\r\n(\S){1}/, '\1 \2')
    parsed_book = []
    until clean_data.empty?
       text_set = clean_data.truncate(1000, separator: /\s/, omission:'')
       parsed_book << text_set
       clean_data.sub!(text_set, '')
    end
    parsed_book
  end
end
