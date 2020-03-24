# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'books', type: :system do
  let(:user) { create(:user) }
  let(:another_user) { create(:user) }

  context 'when user has logged in' do
    background do
      @book = create(:book)
      login_as(user)
    end

    scenario 'is user can add book correctly' do
      visit books_path
      expect(page).to have_selector 'h5', text: @book.title
      expect { click_button I18n.t(:add_to_bookshelf) }.to change { user.bookshelf.books.count }.by(1)
      @book.reload
      expect(@book.bookshelf_books_count).to eq 1
      expect(page).to have_selector '.alert-success', text: I18n.t(:added_to_bookshelf)
      expect(current_path).to eq user_path(user)
      visit books_path
      expect(page).to have_selector 'button', text: I18n.t(:already_added)
    end
  end

  context 'when user does not log in' do
    background { create(:book) }

    scenario 'is redirected to login page' do
      visit books_path
      expect(page).to have_selector 'h5', text: Book.first.title
      click_button I18n.t(:add_to_bookshelf)
      expect(current_path).to eq login_path
      expect(page).to have_selector '.alert-danger', text: I18n.t(:please_login)
    end
  end
end
