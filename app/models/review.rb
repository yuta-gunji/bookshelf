# frozen_string_literal: true

class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :title, presence: true
  validates :content, presence: true
  validates :rate, presence: true, numericality: { only_integer: true }
  validates :user, presence: true
  validates :book, presence: true
  validates :reviewed_at, presence: true
end
