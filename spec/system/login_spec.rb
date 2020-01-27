# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Login', type: :system do
  let(:user) { create(:user) }

  scenario 'login with valid information' do
    visit login_path
    expect(page).to have_link 'こちら', href: signup_path

    fill_in User.human_attribute_name(:email), with: user.email
    fill_in User.human_attribute_name(:password), with: 'password'
    click_button I18n.t(:login)
    expect(page).to have_link I18n.t(:logout), href: logout_path
    expect(page).not_to have_link I18n.t(:login), href: login_path
  end

  scenario 'login with valid information followed by multi logout process' do
    login!
    click_link I18n.t(:logout), href: logout_path
    expect(page).to have_link I18n.t(:login), href: login_path
    page.driver.submit :delete, '/logout', {} # It is assumed logout process from another tab in the same browser.
    expect(page).to have_link I18n.t(:login), href: login_path
  end

  scenario 'login with remembering' do
    login_as(user, remember: '1')
    expect(page.driver.browser.rack_mock_session.cookie_jar[:remember_token]).to be_truthy
  end

  scenario 'login without remembering' do
    login_as(user, remember: '0')
    expect(page.driver.browser.rack_mock_session.cookie_jar[:remember_token]).to be_falsey
  end
end
