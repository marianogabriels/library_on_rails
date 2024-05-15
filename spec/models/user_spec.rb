require 'rails_helper'

RSpec.describe User, type: :model do

  describe "Role" do
    let(:member) { User.create(email: 'member@example.com', password: 'password', role: 'member') }
    let(:librarian) { User.create(email: 'librarian@example.com', password: 'password', role: 'librarian') }

    it('#member?') { expect(member.member?).to be(true)  }
    it('#librarian?') { expect(librarian.librarian?).to be(true)  }
  end

  describe '.with_overdue_books' do
    let!(:user_with_overdue_book) { FactoryBot.create(:user, email: 'overdue@example.com') }
    let!(:user_without_overdue_book) { FactoryBot.create(:user, email: 'not_overdue@example.com') }
    let!(:book) { FactoryBot.create(:book) }

    before do
      FactoryBot.create(:borrow, user: user_with_overdue_book, book: book, due_at: 2.weeks.ago)
      FactoryBot.create(:borrow, user: user_without_overdue_book, book: book, due_at: 2.weeks.from_now)
    end

    it 'returns users with overdue books' do
      overdue_users = User.with_overdue_books
      expect(overdue_users).to include(user_with_overdue_book)
      expect(overdue_users).not_to include(user_without_overdue_book)
    end
  end
end
