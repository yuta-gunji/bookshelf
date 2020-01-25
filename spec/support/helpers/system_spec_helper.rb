# frozen_string_literal: true

module SystemSpecHelper
  # @param user [User]
  def login_as(user)
    visit login_path
    fill_in User.human_attribute_name(:email), with: user.email
    fill_in User.human_attribute_name(:password), with: 'password'
    click_button I18n.t(:login)
  end

  def login!
    user = create(:user)
    login_as(user)
  end

  def logout
    click_link I18n.t(:logout)
  end
end
