class PaginateFacade
  def initialize(user_book)
    @current_page = user_book.current_page
    @guten_id = user_book.book.guten_id
  end

  def get_gutenberg_book
    JestamouseService.new.get_book_text(@guten_id)
  end

  def remove_extra_returns(raw_text)
    raw_text.gsub(/(\S)\r\n(\S){1}/, '\1 \2')
  end

  def paginate_text(clean_text)
    paginated_book = []
    until clean_text.empty?
      text_set = clean_text.truncate(600, separator: /\s/, omission: '')
      paginated_book.push(text_set.lstrip)
      clean_text.sub!(text_set, '')
    end
    paginated_book
  end

  def paginated_gutenberg
    raw_text = get_gutenberg_book
    clean_text = remove_extra_returns(raw_text)
    paginate_text(clean_text)
  end

  def get_paginated_book
    {
      current_page: @current_page,
      book: paginated_gutenberg
    }
  end
end
