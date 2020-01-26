# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Signup', type: :system do
  scenario 'is processed correctly' do
    visit signup_path
    expect(page).to have_link 'こちら', href: login_path

    fill_in User.human_attribute_name(:name), with: 'yuta'
    fill_in User.human_attribute_name(:email), with: 'example@example.com'
    fill_in User.human_attribute_name(:password), with: 'password'
    fill_in User.human_attribute_name(:password_confirmation), with: 'password'

    expect { click_button I18n.t(:register) }.to change { User.count }.by(1)
    expect(current_path).to eq root_path
    expect(page).to have_link I18n.t(:logout), href: logout_path
    expect(page).not_to have_link I18n.t(:login), href: login_path
  end

  scenario 'has some errors' do
    visit signup_path
    fill_in User.human_attribute_name(:name), with: 'yuta'
    fill_in User.human_attribute_name(:email), with: 'invailid_email@'
    fill_in User.human_attribute_name(:password), with: 'password'
    fill_in User.human_attribute_name(:password_confirmation), with: 'another_password'

    expect { click_button I18n.t(:register) }.not_to change(User, :count)
    expect(current_path).to eq signup_path
    expect(page).to have_css '#error_explanation'
  end
end
