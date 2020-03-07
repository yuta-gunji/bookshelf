# frozen_string_literal: true

class CreateRelationships < ActiveRecord::Migration[6.0]
  def change
    create_table :relationships do |t|
      t.bigint :followed_id, null: false
      t.bigint :follower_id, null: false

      t.timestamps
    end

    add_foreign_key :relationships, :users, column: :followed_id
    add_foreign_key :relationships, :users, column: :follower_id
    add_index :relationships, :followed_id
    add_index :relationships, :follower_id
    add_index :relationships, %i[followed_id follower_id], unique: true
  end
end
