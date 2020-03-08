# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Users', type: :system do
  let(:user) { create(:user) }
  let(:another_user) { create(:user) }

  before do
    user.create_bookshelf
    another_user.create_bookshelf
  end

  context 'when user logged in' do
    before do
      user.follow(another_user)
      another_user.follow(user)
      login_as(user)
    end

    scenario 'count of followings and followers is displayed' do
      visit user_path(user)
      expect(page).to have_selector '#followings-count', text: user.followings.count
      expect(page).to have_selector '#followers-count', text: user.followers.count
    end

    scenario 'follow button does not displayed in my page' do
      visit user_path(user)
      expect(page).not_to have_selector '#follow_form'
    end
  end

  context 'when user does not log in' do
    before do
      user.follow(another_user)
      another_user.follow(user)
    end

    scenario 'count of followings and followers is displayed' do
      visit user_path(user)
      expect(page).to have_selector '#followings-count', text: user.followings.count
      expect(page).to have_selector '#followers-count', text: user.followers.count
    end

    scenario 'follow button does not displayed' do
      visit user_path(user)
      expect(page).not_to have_selector '#follow_form'
    end
  end
end
