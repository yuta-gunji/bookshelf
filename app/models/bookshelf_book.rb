# frozen_string_literal: true

class BookshelfBook < ApplicationRecord
  belongs_to :bookshelf
  belongs_to :book
end
