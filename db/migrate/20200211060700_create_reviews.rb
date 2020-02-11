# frozen_string_literal: true

class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.string  :title, null: false
      t.text    :content, null: false
      t.integer :rate, null: false
      t.bigint  :book_id, null: false
      t.bigint  :user_id, null: false
      t.date    :reviewed_at, null: false

      t.timestamps
    end

    add_foreign_key :reviews, :books
    add_foreign_key :reviews, :users
    add_index :reviews, :book_id
    add_index :reviews, :user_id
  end
end
