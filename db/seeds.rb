# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
UserBook.destroy_all
User.destroy_all
Book.destroy_all

# Create users
user1 = User.create(
  username: 'Bob',
  email: 'bob@example.com',
  password: 'bob',
  password_confirmation: 'bob')

user2 = User.create(
  username: 'Sue',
  email: 'sue@example.com',
  password: 'sue',
  password_confirmation: 'sue')

# Create books
book1 = Book.create(
  title: 'Alice in Wonderland',
  author: 'Lewis Carroll',
  guten_id: 11)

book2 = Book.create(
  title: 'Dracula',
  author: 'Bram Stoker',
  guten_id: 345)

book3 = Book.create(
  title: 'Adventures of Huckleberry Finn',
  author: 'Mark Twain',
  guten_id: 76)

# Create user_books
UserBook.create(user: user1, book: book1, current_page: 0)
UserBook.create(user: user1, book: book2, current_page: 23)
UserBook.create(user: user2, book: book2, current_page: 34)
UserBook.create(user: user2, book: book3, current_page: 12)