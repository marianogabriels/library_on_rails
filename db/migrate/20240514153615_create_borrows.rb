class CreateBorrows < ActiveRecord::Migration[7.1]
  def change
    create_table :borrows do |t|
      t.references :user, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true
      t.datetime :due_at
      t.datetime :returned_at

      t.timestamps
    end
  end
end
