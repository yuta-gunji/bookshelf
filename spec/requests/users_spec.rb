# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET #index' do
    let(:user_1) { create(:user) }
    let(:user_2) { create(:user) }
    before do
      create(:bookshelf, user: user_1)
      create(:bookshelf, user: user_2)
    end

    it 'succeeds' do
      get users_path
      expect(response.status).to eq 200
    end

    it 'displays names of users' do
      get users_path
      expect(response.body).to include user_1.name
      expect(response.body).to include user_2.name
    end
  end

  describe 'GET #show' do
    let(:user) { create(:user) }
    before do
      create(:bookshelf, user: user)
    end

    it 'succeeds' do
      get user_path(user)
      expect(response.status).to eq 200
    end

    it 'displays name of user' do
      get users_path
      expect(response.body).to include user.name
    end
  end
end
