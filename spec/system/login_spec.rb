# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Login', type: :system do
  let(:user) { create(:user) }

  scenario 'login' do
    visit login_path
    fill_in User.human_attribute_name(:email), with: user.email
    fill_in User.human_attribute_name(:password), with: 'password'
    click_button I18n.t(:login)
    expect(page).to have_link I18n.t(:logout), href: logout_path
    expect(page).not_to have_link I18n.t(:login), href: login_path
  end
end
