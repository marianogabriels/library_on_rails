class Book < ApplicationRecord

  has_many :borrows
  has_many :borrowers, through: :borrows, source: :user

  def self.search(query)
    sanitized_query = sanitize_sql_like(query)
    where("title ilike ? or author ilike ? or genre ilike ?", "%#{sanitized_query}%", "%#{sanitized_query}%", "%#{sanitized_query}%")
  end

  def available?
    borrows.where(returned_at: nil).count < total_copies
  end
end
