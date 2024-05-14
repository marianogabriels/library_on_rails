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

end
