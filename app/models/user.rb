class User < ApplicationRecord
  has_secure_password

  has_many :user_books
  has_many :books, through: :user_books

  validates_presence_of :username, :email
  validates :password, confirmation: true

  enum role: [:user, :admin]
  
  def all_books
     books.includes(:user_books)
      .select(:id, :guten_id, :author, :title, :current_page)
      .order(id: :asc)
  end
end
