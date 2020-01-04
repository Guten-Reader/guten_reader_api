require 'rails_helper'

describe Book do
  describe 'validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :author }
    it { should validate_presence_of :guten_id }
  end

  describe 'relationships' do
    it { should have_many :user_books }
    it { should have_many(:users).through(:user_books) }
  end

  describe 'class methods' do
    describe '::create_or_add_book' do
      scenario 'adds a record to books table if it does not exist' do 
        books = Book.all
        expect(books).to eq([])

        new_book = Book.create_or_add_book(11, 'Alice in Wonderland', 'Lewis Carroll')

        books = Book.all
        expect(books.first).to eq(new_book)
      end

      scenario 'returns book if it is in books table' do
        alice = create(:book, guten_id: 11, title: 'Alice in Wonderland', author: 'Lewis Carroll')

        books = Book.all
        expect(books.length).to eq(1)
        expect(books.first).to eq(alice)

        new_book = Book.create_or_add_book(11, 'Alice in Wonderland', 'Lewis Carroll')

        books = Book.all
        expect(books.length).to eq(1)
        expect(books.first).to eq(alice)
      end
    end
  end
end