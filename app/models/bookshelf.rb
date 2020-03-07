# frozen_string_literal: true

class Bookshelf < ApplicationRecord
  has_many :bookshelf_books, dependent: :destroy
  has_many :books, through: :bookshelf_books
  belongs_to :user

  before_create :set_name

  def add!(book)
    record = books.find_by(id: book.id)
    books << book unless record
  end

  private

  def set_name
    self.name = user.name + 'さんの本棚'
  end
end
