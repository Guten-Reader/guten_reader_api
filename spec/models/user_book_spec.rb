require 'rails_helper'

describe UserBook do
  describe 'validations' do
    it { should validate_presence_of :book_id }
    it { should validate_presence_of :user_id }
    scenario 'user can only have one copy of a book' do
      create(:user_book)
      should validate_uniqueness_of(:book_id).scoped_to(:user_id)
    end
  end

  describe 'relationships' do
    it { should belong_to :user }
    it { should belong_to :book }
  end

  describe 'class methods' do
    describe '::user_checked_out_book?' do
      scenario 'returns false if no user_book record with :book_id, :user_id' do
        result = UserBook.user_checked_out_book?(1, 1)
        refute(result)
      end

      scenario 'returns true if user_book record with :book_id, :user_id' do
        user, book = create(:user), create(:book)
        create(:user_book, user: user, book: book)

        result = UserBook.user_checked_out_book?(book.id, user.id)
        assert(result)
      end
    end

    describe '::checkout_book' do
      it 'creates a user_book for the user' do
        user = create(:user)
        expect(user.user_books).to eq([])

        book = create(:book)

        UserBook.checkout_book(book.id, user.id)
        
        expect(user.books).to eq([book])
      end
    end
  end
end

