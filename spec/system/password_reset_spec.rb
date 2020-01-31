# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'PasswordReset', type: :system do
  let(:user) { create(:user, password: 'old_password') }
  let(:new_password) { 'new_password' }

  context 'when reset email is sent' do
    scenario 'email is sent correctly' do
      visit new_password_reset_path
      expect(current_path).to eq new_password_reset_path

      fill_in User.human_attribute_name(:email), with: user.email
      click_button I18n.t(:send)
      expect(current_path).to eq root_path
      expect(page).to have_selector '.alert-info', text: I18n.t(:sent_password_reset_link)
      expect(ActionMailer::Base.deliveries.size).to eq 1
    end
  end

  context 'when reset password' do
    let(:reset_token) { user.reset_token }
    before { user.create_reset_digest }

    scenario 'password has been reset' do
      visit edit_password_reset_path(user.reset_token, email: user.email)
      expect(current_path).to eq edit_password_reset_path(reset_token)
      expect(find('#email', visible: false).value).to eq user.email
      fill_in I18n.t(:new_passwrod), with: new_password
      fill_in I18n.t(:new_passwrod_confirmation), with: new_password
      click_button I18n.t(:update)
      expect(page).to have_selector '.alert-success', text: I18n.t(:passwrod_has_been_reset)
      expect(current_path).to eq root_path
      expect(user.reload.reset_digest).to be_falsey
    end
  end
end
