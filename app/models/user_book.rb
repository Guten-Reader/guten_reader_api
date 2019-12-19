class UserBook < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates_presence_of :book_id, :user_id

  def self.add_book()
    UserBook.create()
  end
end
