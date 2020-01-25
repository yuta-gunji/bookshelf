# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "user_name_#{n}" }
    sequence(:email) { |n| "example#{n}@example.co.jp" }
    password { 'password' }
  end
end
