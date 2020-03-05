# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Like', type: :system do
  let(:user) { create(:user) }
  let(:book) { create(:book) }

  context 'when login' do
    before do
      @review = create(:review, book: book)
      create_bookshelf(user)
      login_as(user)
    end

    scenario 'user can press like button to review', js: true do
      visit book_path(book)
      expect(current_path).to eq book_path(book)
      expect(page).to have_selector "#likes-count-#{@review.id}", text: 0
      find("#like-link-#{@review.id}").click
      sleep 1.0
      expect(page).to have_selector "#likes-count-#{@review.id}", text: 1
    end
  end

  context 'when not login' do
    before do
      @review = create(:review, book: book)
    end

    scenario 'user can not press like button to review' do
      visit book_path(book)
      expect(current_path).to eq book_path(book)
      expect(page).to have_selector "#likes-count-#{@review.id}", text: 0
      expect(page).not_to have_link "#like-link-#{@review.id}"
    end
  end
end
