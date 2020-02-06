# frozen_string_literal: true

class CreateBookshelves < ActiveRecord::Migration[6.0]
  def change
    create_table :bookshelves do |t|
      t.bigint :user_id, null: false
      t.string :name, null: false

      t.timestamps
    end

    add_index :bookshelves, :user_id, unique: true
    add_foreign_key :bookshelves, :users
  end
end
