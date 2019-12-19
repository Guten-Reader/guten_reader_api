class Book < ApplicationRecord
  has_many :user_books
  has_many :users, through: :user_books

  validates_presence_of :title, :author, :guten_id

  def self.create_or_add_book(guten_id, title, author)
    Book.where(guten_id: guten_id,
                      title: title,
                      author: author)
                .first_or_create
  end

end
