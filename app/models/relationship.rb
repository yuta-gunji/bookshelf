# frozen_string_literal: true

class Relationship < ApplicationRecord
  validates :follower_id, presence: true
  validates :followed_id, presence: true
end
