# frozen_string_literal: true

FactoryBot.define do
  factory :bookshelf_book do
    book
    bookshelf
    adding_date { Date.current }
  end
end
