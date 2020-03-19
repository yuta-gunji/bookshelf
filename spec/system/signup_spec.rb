# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Signup', type: :system do
  let(:valid_email) { 'example@example.com' }
  let(:invalid_email) { 'invailid_email@' }
  let(:password) { 'password' }
  let(:another_password) { 'another_password' }

  scenario 'signup with valid information' do
    visit signup_path
    expect(page).to have_link 'こちら', href: login_path

    fill_in User.human_attribute_name(:name), with: 'name'
    fill_in User.human_attribute_name(:email), with: valid_email
    fill_in User.human_attribute_name(:password), with: password
    fill_in User.human_attribute_name(:password_confirmation), with: password
    expect { click_button I18n.t(:register) }.to change { User.count }.by(1).and change { Bookshelf.count }.by(1)
    expect(ActionMailer::Base.deliveries.size).to eq 1
    expect(current_path).to eq login_path
    expect(page).to have_link I18n.t(:login), href: login_path
    expect(page).not_to have_link I18n.t(:logout), href: logout_path
  end

  scenario 'signup with invalid information' do
    visit signup_path
    fill_in User.human_attribute_name(:name), with: 'name'
    fill_in User.human_attribute_name(:email), with: invalid_email
    fill_in User.human_attribute_name(:password), with: password
    fill_in User.human_attribute_name(:password_confirmation), with: another_password
    expect { click_button I18n.t(:register) }.not_to change(User, :count)

    expect(current_path).to eq signup_path
    expect(page).to have_css '#error_explanation'
  end
end
