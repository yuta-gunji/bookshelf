# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Reviews', type: :system do
  let(:user) { create(:user) }
  let(:book) { create(:book) }
  let(:title) { 'awesome title' }
  let(:content) { 'very good book!' }

  context 'when user login' do
    context 'when already added book to bookshelf' do
      before do
        bookshelf = create_bookshelf(user)
        add_to_bookshelf(bookshelf, book)
        login_as(user)
      end

      scenario 'user can create review' do
        visit book_path(book)
        expect(current_path).to eq book_path

        fill_in Review.human_attribute_name(:title), with: title
        fill_in Review.human_attribute_name(:content), with: content
        expect { click_button I18n.t(:write) }
          .to { change(user.bookshelf.books, :count).by(0) }
          .and { change { user.review.count }.by(1) }
        expect(current_path).to book_path(book)
        expect(page).to have_selector '.alert-success', text: I18n.t(:successfully_created)
        expect(page).to have_content title
      end
    end

    context 'when user does not add book to bookshelf' do
      before do
        create_bookshelf(user)
        login_as(user)
      end

      scenario 'user can add book to bookshelf and create review' do
        visit book_path(book)
        expect(current_path).to eq book_path

        fill_in Review.human_attribute_name(:title), with: title
        fill_in Review.human_attribute_name(:content), with: content
        expect { click_button I18n.t(:write) }
          .to { change { user.bookshelf.books.count }.by(1) }
          .and { change { user.review.count }.by(1) }
        expect(current_path).to book_path(book)
        expect(page).to have_selector '.alert-success', text: I18n.t(:successfully_created)
      end
    end
  end

  context 'when user does not login' do
    scenario 'review form does not displayed' do
      visit book_path(book)
      expect(current_path).to eq book_path
      expect(page).not_to have_content I18n.t(:write_review)
    end
  end
end
