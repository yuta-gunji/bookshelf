# frozen_string_literal: true

FactoryBot.define do
  factory :book do
    sequence(:title) { |n| "title_#{n}" }
    sequence(:authors) { |n| "author_#{n}, author_#{n + 1}" }
    sequence(:publisher) { |n| "publisher_#{n}" }
    published_date { Date.today }
    image_url { nil }
    description { 'description' }
    isbn_10 { nil }
    isbn_13 { nil }
    google_book_id { SecureRandom.hex(6) }
  end
end
