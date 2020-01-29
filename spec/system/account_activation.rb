# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'AccountActivation', type: :system do
  let(:user) { create(:user, activated: false, activated_at: nil) }
  let(:another_user) { create(:user) }

  context 'when activation link is valid' do
    scenario 'is activated correctly' do
      # User can't login bofore account activation.
      login_as(user)
      expect(page).to have_link I18n.t(:login), href: login_path
      expect(page).not_to have_link I18n.t(:logout), href: logout_path

      # User can login after account activation.
      visit edit_account_activation(user.activation_token, email: user.email)
      expect(page).to have_link I18n.t(:logout), href: logout_path
      expect(page).not_to have_link I18n.t(:login), href: login_path
      expect(page).to have_selector '.alert-success', text: I18n.t(:successfully_activated)
    end
  end

  context 'when activation link is invalid' do
    scenario 'is not activated' do
      login_as(user)
      visit edit_account_activation(user.activation_token, email: another_user.email)
      expect(page).to have_link I18n.t(:login), href: login_path
      expect(page).not_to have_link I18n.t(:logout), href: logout_path
      expect(page).to have_selector '.alert-success', text: I18n.t(:invalid_activation_link)
    end
  end
end
