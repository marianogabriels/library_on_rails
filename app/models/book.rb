class Book < ApplicationRecord

  has_many :borrows
  has_many :borrowers, through: :borrows, source: :user

  def self.search(query)
    sanitized_query = sanitize_sql_like(query)
    where("title ILIKE ? OR author ILIKE ? OR genre ILIKE ?", "%#{sanitized_query}%", "%#{sanitized_query}%", "%#{sanitized_query}%")
  end

  def available?
    borrows.where(returned_at: nil).count < total_copies
  end
end
