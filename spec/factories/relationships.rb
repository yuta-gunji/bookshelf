# frozen_string_literal: true

FactoryBot.define do
  factory :relationship do
    follower_id { create(:user).id }
    followed_id { create(:user).id }
  end
end
