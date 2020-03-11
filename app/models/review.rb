# frozen_string_literal: true

class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book
  has_many :likes, dependent: :destroy

  validates :title, presence: true
  validates :content, presence: true
  validates :rate, presence: true, numericality: { only_integer: true }
  validates :user, presence: true
  validates :book, presence: true
  validates :reviewed_at, presence: true

  scope :recent, -> { order(reviewed_at: :desc) }

  paginates_per 12

  def already_liked?(user)
    likes.find_by(user_id: user.id)
  end
end
