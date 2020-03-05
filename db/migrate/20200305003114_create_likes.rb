# frozen_string_literal: true

class CreateLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :likes do |t|
      t.bigint :review_id, null: false
      t.bigint :user_id, null: false
      t.date   :liked_at, null: false

      t.timestamps
    end

    add_foreign_key :likes, :reviews
    add_foreign_key :likes, :users
    add_index :likes, :review_id
    add_index :likes, :user_id
    add_index :likes, %i[review_id user_id], unique: true
  end
end
