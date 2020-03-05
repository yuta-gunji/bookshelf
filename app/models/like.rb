# frozen_string_literal: true

class Like < ApplicationRecord
  belongs_to :review
  belongs_to :user

  validates :review, presence: true
  validates :user, presence: true
  validates :review_id, uniqueness: { scope: :user_id }

  before_create :set_liked_at

  private

  def set_liked_at
    self.liked_at = Date.current
  end
end
