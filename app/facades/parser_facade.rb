require 'epub/parser'

class ParserFacade
  def initialize()
  end

  def get_paginated_book(user_book, full_text)
    {
      current_page: user_book.current_page,
      book: paginate_text(full_text)
    }
  end

  def paginate_text(full_text)
    clean_data = full_text.gsub(/(\S)\r\n(\S){1}/, '\1 \2')
    paginated_book = []
    until clean_data.empty?
      text_set = clean_data.truncate(1000, separator: /\s/, omission:'')
      paginated_book << text_set
      clean_data.sub!(text_set, '')
    end
    return paginated_book
  end
end
