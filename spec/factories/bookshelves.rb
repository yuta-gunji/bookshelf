# frozen_string_literal: true

FactoryBot.define do
  factory :bookshelf do
    user
    sequence(:name) { |n| "bookshelf_#{n}" }
  end
end
