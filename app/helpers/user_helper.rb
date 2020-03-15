# frozen_string_literal: true

module UserHelper
  def resized_avatar(user)
    user.avatar.variant(resize_to_fill: [150, 150])
  end
end
