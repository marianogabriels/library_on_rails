require 'rails_helper'

RSpec.describe Book, type: :model do
  it "is valid with a title, author, genre, isbn, and total copies" do
    book = Book.new(
      title: "The Great Gatsby",
      author: "F. Scott Fitzgerald",
      genre: "Fiction",
      isbn: "9780743273565",
      total_copies: 5
    )
    expect(book).to be_valid
  end
end
