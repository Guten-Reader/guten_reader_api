require 'epub/parser'

class ParserFacade
  def initialize()
  end

  def parse_data(data)
    clean = data[:body].gsub(/(\S)\r\n(\S){1}/, '\1 \2')
    chicken = clean
    parsed_book = []
    until chicken == nil
      binding.pry
       parsed_book << chicken.truncate(1000, separator: /\s/)
    end
    parsed_book
  end
end
