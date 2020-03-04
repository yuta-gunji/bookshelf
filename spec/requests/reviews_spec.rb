# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Reviews', type: :request do
  describe 'GET #edit' do
    let(:book) { create(:book) }
    let(:user_1) { create(:user) }
    let(:user_2) { create(:user) }

    context 'when editing review by oneself' do
      before do
        create(:bookshelf, user: user_1)
        @review = create(:review, user: user_1, book: book)
        login_as(user_1)
      end

      it 'succeeds' do
        get edit_review_path(@review.id)
        expect(response.status).to eq 200
      end

      it 'displays title of target review' do
        get edit_review_path(@review)
        expect(response.body).to include @review.title
      end
    end

    context "when trying to edit other your's review" do
      before do
        create(:bookshelf, user: user_1)
        create(:bookshelf, user: user_2)
        @review = create(:review, user: user_1, book: book)
        @review_by_other_user = create(:review, user: user_2, book: book)
        login_as(user_1)
      end

      it 'redirected to root path' do
        get edit_review_path(@review_by_other_user.id)
        expect(response.status).to eq 302
        expect(response).to redirect_to root_path
      end
    end
  end
end
