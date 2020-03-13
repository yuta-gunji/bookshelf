# frozen_string_literal: true

class BookshelfBook < ApplicationRecord
  belongs_to :bookshelf
  belongs_to :book, counter_cache: true

  validates :book_id, presence: true
  validates :bookshelf_id, presence: true
  validates :bookshelf_id, uniqueness: { scope: :book_id }

  before_create :set_adding_date

  private

  def set_adding_date
    self.adding_date = Date.current
  end
end
