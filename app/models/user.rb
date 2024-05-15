class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :rememberable, :validatable
  ROLES = ['member', 'librarian']

  has_many :borrows
  has_many :borrowed_books, through: :borrows, source: :book

  def librarian?
    role == 'librarian'
  end

  def self.with_overdue_books
    joins(:borrows).merge(Borrow.overdue).distinct
  end

  def member?
    role == 'member'
  end
end
