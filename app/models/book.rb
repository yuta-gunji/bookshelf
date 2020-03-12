# frozen_string_literal: true

class Book < ApplicationRecord
  has_many :bookshelf_books, dependent: :destroy
  has_many :bookshelves, through: :bookshelf_books
  has_many :reviews, dependent: :destroy

  validates :title, presence: true
  validates :google_books_id, presence: true, uniqueness: true

  scope :recent, -> { order(created_at: :desc) }

  paginates_per 12
end
