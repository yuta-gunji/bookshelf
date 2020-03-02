# frozen_string_literal: true

module RequestSpecHelper
  def login_as(user)
    allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return(user_id: user.id)
  end
end
