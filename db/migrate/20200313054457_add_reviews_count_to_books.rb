# frozen_string_literal: true

class AddReviewsCountToBooks < ActiveRecord::Migration[6.0]
  def up
    add_column :books, :reviews_count, :integer, null: false, default: 0
    Book.find_each { |i| Book.reset_counters(i.id, :reviews_count) }
  end

  def down
    remove_column :books, :reviews_count, :integer
  end
end
