# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Reviews', type: :system do
  let(:user) { create(:user) }
  let(:book) { create(:book) }
  let(:title) { 'awesome title' }
  let(:content) { 'very good book!' }

  context 'when user login' do
    context 'when create new review' do
      before do
        create(:book)
        login_as(user)
      end

      scenario 'user can add book to bookshelf and create review', js: true do
        visit book_path(book)
        expect(current_path).to eq book_path(book)
        fill_in 'review_title', with: title
        fill_in 'review_content', with: content
        expect do
          find('#review_submit').click
        end.to change { user.bookshelf.books.count }.by(1).and change { user.reviews.count }.by(1)
        book.reload
        expect(book.reviews_count).to eq 1
        expect(current_path).to eq book_path(book)
        expect(page).to have_selector '.alert-success', text: I18n.t(:successfully_created)
      end
    end

    context 'when editing review' do
      let(:another_title) { 'another title' }
      let(:another_content) { 'another content' }
      before do
        add_to_bookshelf(user.bookshelf, book)
        @review = create(:review, user: user, book: book, title: title, content: content)
        login_as(user)
      end

      scenario 'user can edit review' do
        visit book_path(book)
        expect(current_path).to eq book_path(book)
        first('.edit_review').click_link I18n.t(:edit)
        expect(current_path).to eq edit_review_path(@review)

        fill_in Review.human_attribute_name(:title), with: another_title
        fill_in Review.human_attribute_name(:content), with: another_content
        expect { click_button I18n.t(:update) }
          .to change { user.reviews.count }.by(0)
          .and change { Review.find(@review.id).title }.from(title).to(another_title)
          .and change { Review.find(@review.id).content }.from(content).to(another_content)
        expect(current_path).to eq book_path(book)
        expect(page).to have_selector '.alert-success', text: I18n.t(:successfully_updated)
        expect(page).to have_content another_title
        expect(page).to have_content another_content
      end
    end
  end

  context 'when user does not login' do
    scenario 'review form does not displayed' do
      visit book_path(book)
      expect(current_path).to eq book_path(book)
      expect(page).not_to have_content I18n.t(:write_review)
    end
  end
end
