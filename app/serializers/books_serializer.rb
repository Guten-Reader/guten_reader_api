class BooksSerializer
  def initialize(books_array)
    @books = books_array.map { |book| BookFormatter.new(book) }
  end
end