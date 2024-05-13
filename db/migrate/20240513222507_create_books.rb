class CreateBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :genre
      t.string :isbn
      t.integer :total_copies

      t.timestamps
    end
  end
end
