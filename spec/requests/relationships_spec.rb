# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Relationships', type: :request do
  describe 'POST #create' do
    let(:user) { create(:user) }
    let(:another_user) { create(:user) }

    context 'when user does not log in' do
      it 'user is redirected to login page' do
        expect do
          post relationships_path, params: { followed_id: another_user.id }
        end.not_to change(Relationship, :count)
        expect(response.status).to eq 302
        expect(response).to redirect_to login_path
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:user) { create(:user) }
    let(:another_user) { create(:user) }

    context 'when user does not log in' do
      before { create(:relationship, follower_id: user.id, followed_id: another_user.id) }

      it 'user is redirected to login page' do
        expect do
          delete relationship_path(user.active_relationships.find_by(followed_id: another_user.id))
        end.not_to change(Relationship, :count)
        expect(response.status).to eq 302
        expect(response).to redirect_to login_path
      end
    end
  end
end
