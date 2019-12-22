class PaginateFacade

  def get_gutenberg_book(guten_id)
    JestamouseService.new.get_book_text(guten_id)
  end

  def remove_extra_returns(raw_text)
    raw_text.gsub(/(\S)\r\n(\S){1}/, '\1 \2')
  end

  def paginate_text(clean_text)
    paginated_book = []
    until clean_text.empty?
      text_set = clean_text.truncate(600, separator: /\s/, omission:'')
      paginated_book.push(text_set.lstrip)
      clean_text.sub!(text_set, '')
    end
    return paginated_book
  end

  def paginated_gutenberg(guten_id)
    raw_text = get_gutenberg_book(guten_id)
    clean_text = remove_extra_returns(raw_text)
    return paginate_text(clean_text)
  end

  def get_paginated_book(user_book, guten_id)
    {
      current_page: user_book.current_page,
      book: paginated_gutenberg(guten_id)
    }
  end
end
