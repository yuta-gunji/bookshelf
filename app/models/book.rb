# frozen_string_literal: true

class Book < ApplicationRecord
  has_many :bookshelf_books
  has_many :bookshelves, through: :bookshelf_books
end
