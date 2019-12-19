class UserBook < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates_presence_of :book_id, :user_id
  validates :book_id, uniqueness: { scope: :user_id}


  def self.user_checked_out_book?(book_id, user_id)
    UserBook.find_by(book_id: book_id, user_id: user_id)
  end

  def self.checkout_book(book_id, user_id)
    UserBook.create(book_id: book_id, user_id: user_id)
  end
end
