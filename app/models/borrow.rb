class Borrow < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :book_id, uniqueness: { scope: :user_id, message: "can't be borrowed multiple times by the same user" }

  before_create :set_due_at, if: :new_record?

  private

  def set_due_at
    self.due_at ||= 2.weeks.from_now
  end

end
