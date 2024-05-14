require 'rails_helper'

RSpec.describe Borrow, type: :model do
  let(:user) { User.create!(email: 'user@example.com', password: 'password') }
  let(:book) { Book.create!(title: 'The Hobbit', author: 'J.R.R. Tolkien', genre: 'Fantasy', total_copies: 2) }
  let(:borrow) { Borrow.new(user: user, book: book) }

  describe 'associations' do
    it { expect(borrow.user).to be_a(User) }
    it { expect(borrow.book).to be_a(Book)  }
  end

  describe 'callbacks' do
    it 'sets due_at when borrow is created' do
      borrow = Borrow.new(user: user, book: book)
      expect { borrow.save! }.to change { borrow.due_at }.from(nil).to be_within(10.second).of(2.weeks.from_now)
    end
  end


  describe 'validations' do

    let(:user1) { FactoryBot.create(:user) }
    let(:user2) { FactoryBot.create(:user) }
    let(:book) { FactoryBot.create(:book, total_copies: 1) }

    it 'allows different users to borrow the same book if copies are available' do
      book.update(total_copies: 2)
      borrow1 = Borrow.create(user: user1, book: book)
      borrow2 = Borrow.create(user: user2, book: book)

      expect(borrow1).to be_valid
      expect(borrow2).to be_valid
    end

    it 'does not allow the same user to borrow the same book multiple times' do
      Borrow.create(user: user1, book: book)
      duplicate_borrow = Borrow.new(user: user1, book: book)

      expect(duplicate_borrow).not_to be_valid
      expect(duplicate_borrow.errors[:book_id]).to include("can't be borrowed multiple times by the same user")
    end

    it 'does not allow borrowing a book if no copies are available' do
      Borrow.create(user: user1, book: book)
      borrow = Borrow.new(user: user2, book: book)

      expect(borrow).not_to be_valid
      expect(borrow.errors[:book]).to include("has no available copies")
    end
  end

end
