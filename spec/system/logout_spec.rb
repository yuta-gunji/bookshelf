# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Logout', type: :system do
  scenario 'logout' do
    login!
    visit root_path
    click_link I18n.t(:logout), href: logout_path
    expect(page).to have_link I18n.t(:login), href: login_path
    expect(page).not_to have_link I18n.t(:logout), href: logout_path
  end
end
