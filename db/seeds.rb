# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

users = [
  { email: 'user1@example.com', password: 'password123', role: 'member' },
  { email: 'user2@example.com', password: 'password123', role: 'member' },
  { email: 'librarian@example.com', password: 'password123', role: 'librarian' }
]

users.each do |user_attributes|
  User.create!(user_attributes)
end

books = [
  { title: '1984', author: 'George Orwell', genre: 'Dystopian', isbn: '1234567890', total_copies: 5 },
  { title: 'The Hobbit', author: 'J.R.R. Tolkien', genre: 'Fantasy', isbn: '2345678901', total_copies: 3 },
  { title: 'To Kill a Mockingbird', author: 'Harper Lee', genre: 'Thriller', isbn: '3456789012', total_copies: 4 }
]

books.each do |book_attributes|
  Book.create!(book_attributes)
end

borrows = [
  { user_id: User.find_by(email: 'user1@example.com').id, book_id: Book.find_by(title: '1984').id, due_at: 2.weeks.from_now },
  { user_id: User.find_by(email: 'user2@example.com').id, book_id: Book.find_by(title: 'The Hobbit').id, due_at: 2.weeks.from_now }
]

borrows.each do |borrow_attributes|
  Borrow.create!(borrow_attributes)
end
