# db/seeds.rb

users = [
  { email: 'user1@example.com', password: 'password123', role: 'member' },
  { email: 'user2@example.com', password: 'password123', role: 'member' },
  { email: 'librarian@example.com', password: 'password123', role: 'librarian' }
]

users.each do |user_attributes|
  User.find_or_create_by!(email: user_attributes[:email]) do |user|
    user.password = user_attributes[:password]
    user.role = user_attributes[:role]
  end
end

books = [
  { title: '1984', author: 'George Orwell', genre: 'Dystopian', isbn: '1234567890', total_copies: 5 },
  { title: 'The Hobbit', author: 'J.R.R. Tolkien', genre: 'Fantasy', isbn: '2345678901', total_copies: 3 },
  { title: 'To Kill a Mockingbird', author: 'Harper Lee', genre: 'Thriller', isbn: '3456789012', total_copies: 4 }
]

books.each do |book_attributes|
  Book.find_or_create_by!(isbn: book_attributes[:isbn]) do |book|
    book.title = book_attributes[:title]
    book.author = book_attributes[:author]
    book.genre = book_attributes[:genre]
    book.total_copies = book_attributes[:total_copies]
  end
end

borrows = [
  { user: User.find_by(email: 'user1@example.com'), book: Book.find_by(title: '1984'), due_at: 2.weeks.from_now },
  { user: User.find_by(email: 'user2@example.com'), book: Book.find_by(title: 'The Hobbit'), due_at: 2.weeks.from_now },
  { user: User.find_by(email: 'user1@example.com'), book: Book.find_by(title: 'To Kill a Mockingbird'), due_at: 2.weeks.ago } # Overdue borrow
]

borrows.each do |borrow_attributes|
  Borrow.create!(borrow_attributes)
end
