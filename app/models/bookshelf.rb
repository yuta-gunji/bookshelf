# frozen_string_literal: true

class Bookshelf < ApplicationRecord
  has_many :bookshelf_books
  has_many :books, through: :bookshelf_books
end
