# frozen_string_literal: true

class AddLikesCountToReviews < ActiveRecord::Migration[6.0]
  def change
    add_column :reviews, :likes_count, :integer, null: false, default: 0
  end
end
