# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Reviews', type: :request do
  describe 'GET #edit' do
    let(:book) { create(:book) }
    let(:user_1) { create(:user) }
    let(:user_2) { create(:user) }

    context 'when editing review by oneself' do
      before do
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
        @review = create(:review, user: user_1, book: book)
        @review_by_other_user = create(:review, user: user_2, book: book)
        login_as(user_1)
      end

      it 'redirected to root path' do
        get edit_review_path(@review_by_other_user.id)
        expect(response.status).to eq 302
        expect(response).to redirect_to user_path(user_1)
      end
    end

    context 'when user does not login' do
      before { @review = create(:review, user: user_1, book: book) }

      it 'redirected to login path' do
        get edit_review_path(@review.id)
        expect(response.status).to eq 302
        expect(response).to redirect_to login_path
      end
    end
  end

  describe 'GET #destroy' do
    let(:user) { create(:user) }
    let(:book) { create(:book) }
    before do
      @review = create(:review, user: user, book: book)
      login_as(user)
    end

    it 'succeeds with redirect' do
      expect do
        delete "/reviews/#{@review.id}"
      end.to change { user.reviews.count }.by(-1).and change { book.reviews.count }.by(-1).and change { book.reload.reviews_count }.by(-1)
      expect(response.status).to eq 302
    end
  end
end
