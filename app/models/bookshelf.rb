# frozen_string_literal: true

class Bookshelf < ApplicationRecord
  has_many :bookshelf_books
  has_many :books, through: :bookshelf_books
  belongs_to :user

  def add!(book)
    record = books.find_by(id: book.id)
    books << book unless record
  end
end
