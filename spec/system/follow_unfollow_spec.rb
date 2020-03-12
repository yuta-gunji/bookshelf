# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'FollowAndUnfollow', type: :system do
  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  before { login_as(user) }

  context 'follow' do
    scenario 'user can follow another user', js: true do
      visit user_path(another_user)
      expect(page).to have_link I18n.t(:follow_user)
      expect(page).to have_selector '#followers-count', text: 0
      click_link I18n.t(:follow_user)
      sleep 1
      expect(page).to have_selector '#followers-count', text: 1
      expect(page).to have_link I18n.t(:already_followed)
    end
  end

  context 'unfollow' do
    before { user.follow(another_user) }

    scenario 'user can unfollow another user', js: true do
      visit user_path(another_user)
      expect(page).to have_link I18n.t(:already_followed)
      expect(page).to have_selector '#followers-count', text: 1
      click_link I18n.t(:already_followed)
      sleep 1
      expect(page).to have_selector '#followers-count', text: 0
      expect(page).to have_link I18n.t(:follow_user)
    end
  end
end
