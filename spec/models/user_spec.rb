require 'rails_helper'

describe User do
  describe 'validations' do
    it { should validate_presence_of :username }
    it { should validate_presence_of :email }
    it { should validate_confirmation_of :password }
    it { should have_secure_password }
  end

  describe 'relationships' do 
    it { should have_many :user_books }
    it { should have_many(:books).through(:user_books) }
  end

  describe 'roles' do
    scenario 'default role is 0, :user' do
      user = create(:user)
      expect(user.role).to eq('user')
    end

    scenario 'user can have role 1, :admin' do
      user = create(:user, role: 1)
      expect(user.role).to eq('admin')
    end
  end

  describe 'instance methods' do
    describe '#all_books' do
      scenario 'returns empty array if user has no books' do
        user = create(:user)
        books = user.all_books
        expect(books).to eq([])
      end

      scenario 'returns array of books associated with user' do
        user = create(:user)
        book1, book2, book3 = create(:book), create(:book), create(:book)
        user_book1 = create(:user_book, user: user, book: book1, current_page: 25)
        user_book2 = create(:user_book, user: user, book: book3, current_page: 10)

        books = user.all_books
        
        expect(books[0].id).to eq(book1.id)
        expect(books[0].guten_id).to eq(book1.guten_id)
        expect(books[0].author).to eq(book1.author)
        expect(books[0].title).to eq(book1.title)
        expect(books[0].current_page).to eq(user_book1.current_page)

        expect(books[1].id).to eq(book3.id)
        expect(books[1].guten_id).to eq(book3.guten_id)
        expect(books[1].author).to eq(book3.author)
        expect(books[1].title).to eq(book3.title)
        expect(books[1].current_page).to eq(user_book2.current_page)
      end
    end
  end
end
