# frozen_string_literal: true

FactoryBot.define do
  factory :review do
    sequence(:title) { |n| "title_#{n}" }
    sequence(:content) { |n| "content_#{n}" }
    rate { 3 }
    book
    user
    reviewed_at { Time.current }
  end
end
