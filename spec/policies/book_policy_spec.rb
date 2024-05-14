
require 'rails_helper'

RSpec.describe BookPolicy do
  subject { described_class }

  let(:librarian) { User.create(email: 'librarian@example.com', password: 'password', role: 'librarian') }
  let(:member) { User.create(email: 'member@example.com', password: 'password', role: 'member') }
  let(:book) { Book.create(title: 'Example Book', author: 'Author' ) }

  describe 'scope' do
    it 'includes all books for librarian' do
      expect(Pundit.policy_scope(librarian, Book)).to include(book)
    end

    it 'includes all books for member' do
      expect(Pundit.policy_scope(member, Book)).to include(book)
    end
  end

  describe 'create?' do
    it 'grants access if user is a librarian' do
      expect(subject.new(librarian, book).create?).to be true
    end

    it 'denies access if user is a member' do
      expect(subject.new(member, book).create?).to be false
    end
  end

  describe 'update?' do
    it 'grants access if user is a librarian' do
      expect(subject.new(librarian, book).update?).to be true
    end

    it 'denies access if user is a member' do
      expect(subject.new(member, book).update?).to be false
    end
  end

  describe 'destroy?' do
    it 'grants access if user is a librarian' do
      expect(subject.new(librarian, book).destroy?).to be true
    end

    it 'denies access if user is a member' do
      expect(subject.new(member, book).destroy?).to be false
    end
  end
end
