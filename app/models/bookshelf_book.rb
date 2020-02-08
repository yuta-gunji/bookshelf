# frozen_string_literal: true

class BookshelfBook < ApplicationRecord
  belongs_to :bookshelf
  belongs_to :book

  validates :book_id, presence: true
  validates :bookshelf_id, presence: true
  validates :bookshelf_id, uniqueness: { scope: :book_id }
  validates :adding_date, presence: true

  before_validation :set_adding_date, on: :create

  private

  def set_adding_date
    self.adding_date = Date.current
  end
end
