# frozen_string_literal: true

FactoryBot.define do
  factory :bookshelf_book do
    book
    book_shelf
    adding_date { Date.today }
  end
end
