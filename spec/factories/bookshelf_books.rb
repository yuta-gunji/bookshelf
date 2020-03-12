# frozen_string_literal: true

FactoryBot.define do
  factory :bookshelf_book do
    book_id { nil }
    bookshelf_id { nil }
    adding_date { Date.current }
  end
end
