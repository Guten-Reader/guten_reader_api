require 'epub/parser'

class ParserFacade
  def initialize()
  end

  def parse_data(data)
    clean_data = data[:body].gsub(/(\S)\r\n(\S){1}/, '\1 \2')
    parsed_book = []
    until clean_data.empty?
       text_set = clean_data.truncate(1000, separator: /\s/, omission:'')
       parsed_book << text_set
       clean_data.sub!(text_set, '')
    end
    parsed_book
  end
end
