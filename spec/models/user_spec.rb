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
        create(:user_book, user: user, book: book1)
        create(:user_book, user: user, book: book3)

        books = user.all_books
        expected = [book1, book3]
        expect(books).to eq(expected)
      end
    end
  end
end
