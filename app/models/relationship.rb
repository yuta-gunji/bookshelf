# frozen_string_literal: true

class Relationship < ApplicationRecord
  belongs_to :follower, class_name: 'User'
  belongs_to :followed, class_name: 'User'

  validates :follower_id, presence: true
  validates :followed_id, presence: true
  validate  :prevent_self_following, on: :create

  private

  def prevent_self_following
    errors.add(:follewer_id, I18n.t(:cannot_follow_yourself)) if followed_id == follower_id
  end
end
