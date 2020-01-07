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
  id: 1,
  username: 'Bob',
  email: 'bob@example.com',
  password: 'bob',
  password_confirmation: 'bob',
  refresh_token: ENV['SPOTIFY_REFRESH_TOKEN'])

user2 = User.create(
  id: 2,
  username: 'Sue',
  email: 'sue@example.com',
  password: 'sue',
  password_confirmation: 'sue',
  refresh_token: ENV['SPOTIFY_REFRESH_TOKEN'])

# Create books
book1 = Book.create(
  id: 1,
  title: 'Alice in Wonderland',
  author: 'Lewis Carroll',
  guten_id: 11)

book2 = Book.create(
  id: 2,
  title: 'Dracula',
  author: 'Bram Stoker',
  guten_id: 345)

book3 = Book.create(
  id: 3,
  title: 'Adventures of Huckleberry Finn',
  author: 'Mark Twain',
  guten_id: 76)

# Create user_books
UserBook.create(id: 1, user: user1, book: book1, current_page: 0)
UserBook.create(id: 2, user: user1, book: book2, current_page: 23)
UserBook.create(id: 3, user: user2, book: book2, current_page: 34)
UserBook.create(id: 4, user: user2, book: book3, current_page: 12)
