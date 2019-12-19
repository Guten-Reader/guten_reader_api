require 'epub/parser'

class ParserFacade
  def initialize()
  end

  def parse_data(data)
    clean = data[:body].gsub(/(\S)\r\n(\S){1}/, '\1 \2')
    # book = clean.split.each_slice(300).map{|a|a.join ' '}
  end
end
