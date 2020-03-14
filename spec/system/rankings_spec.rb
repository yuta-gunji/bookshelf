# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Rankings', type: :system do
  let(:user) { create(:user) }
  let(:title) { 'awesome title' }

  before do
    book = create(:book, title: title)
    add_to_bookshelf(user.bookshelf, book)
  end

  scenario 'books is displays' do
    visit rankings_path
    expect(current_path).to eq rankings_path
    expect(page).to have_content I18n.t(:number_of_added_to_bookshelf) + I18n.t(:ranking)
    expect(page).to have_content I18n.t(:number_of_reviews) + I18n.t(:ranking)
    expect(page).to have_content title
  end
end
