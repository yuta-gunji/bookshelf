# frozen_string_literal: true

class ChangeTypeOfReviewedAtInReviews < ActiveRecord::Migration[6.0]
  def up
    change_column :reviews, :reviewed_at, :datetime, null: false
  end

  def down
    change_column :reviews, :reviewed_at, :date, null: false
  end
end
