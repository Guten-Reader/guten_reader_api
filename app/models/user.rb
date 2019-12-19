class User < ApplicationRecord
  has_secure_password

  has_many :user_books
  has_many :books, through: :user_books

  validates_presence_of :username, :email
  validates :password, confirmation: true

  enum role: [:user, :admin]

  def get_user_books
    self.books.select(:id, :guten_id, :author, :title)
  end
end
