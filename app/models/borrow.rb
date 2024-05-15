class Borrow < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validate :unique_active_borrow_per_user, on: :create
  validate :available_copies, on: :create

  before_create :set_due_at, if: :new_record?

  scope :waiting_return, -> { where(returned_at: nil) }
  scope :due_today, -> { where(due_at: Date.today.all_day) }
  scope :overdue, -> { where('due_at < ? AND returned_at IS NULL', Date.today) }
  private


  def set_due_at
    self.due_at ||= 2.weeks.from_now
  end

  def unique_active_borrow_per_user
    if Borrow.where(user_id: user_id, book_id: book_id, returned_at: nil).exists?
      errors.add(:book_id, "can't be borrowed multiple times by the same user")
    end
  end

  def available_copies
    if book.borrows.where(returned_at: nil).count >= book.total_copies
      errors.add(:book, "has no available copies")
    end
  end
end
