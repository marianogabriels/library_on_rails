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

  describe '.search' do

    let!(:book1) { Book.create!(title: 'The Hobbit', author: 'J.R.R. Tolkien', genre: 'Fantasy') }
    let!(:book2) { Book.create!(title: '1984', author: 'George Orwell', genre: 'Dystopia') }
    let!(:book3) { Book.create!(title: 'The Great Gatsby', author: 'F. Scott Fitzgerald', genre: 'Fiction') }

    it 'returns books that match the title' do
      result = Book.search('Hobbit')
      expect(result).to include(book1)
      expect(result).not_to include(book2, book3)
    end

    it 'returns books that match the author' do
      result = Book.search('George Orwell')
      expect(result).to include(book2)
      expect(result).not_to include(book1, book3)
    end

    it 'returns books that match the genre' do
      result = Book.search('Fantasy')
      expect(result).to include(book1)
      expect(result).not_to include(book2, book3)
    end

    it 'is case insensitive' do
      result = Book.search('hobbit')
      expect(result).to include(book1)
    end

    it 'returns all books that match any criteria' do
      result = Book.search('The')
      expect(result).to include(book1, book3)
      expect(result).not_to include(book2)
    end

    it 'returns an empty result if no matches are found' do
      result = Book.search('Nonexistent Book')
      expect(result).to be_empty
    end
  end
end
