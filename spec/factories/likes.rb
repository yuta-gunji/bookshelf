# frozen_string_literal: true

FactoryBot.define do
  factory :like do
    review
    user
    liked_at { Date.current }
  end
end
