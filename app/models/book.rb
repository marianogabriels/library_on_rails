class Book < ApplicationRecord
  def self.search(query)
    sanitized_query = sanitize_sql_like(query)
    where("title ILIKE ? OR author ILIKE ? OR genre ILIKE ?", "%#{sanitized_query}%", "%#{sanitized_query}%", "%#{sanitized_query}%")
  end
end
