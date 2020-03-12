# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET #index' do
    let(:user_name_1) { 'user_name_1' }
    let(:user_name_2) { 'user_name_2' }
    before do
      create(:user, name: user_name_1)
      create(:user, name: user_name_2)
    end

    it 'succeeds' do
      get users_path
      expect(response.status).to eq 200
    end

    it 'displays names of users' do
      get users_path
      expect(response.body).to include user_name_1
      expect(response.body).to include user_name_2
    end
  end

  describe 'GET #show' do
    let(:user_name) { 'user_name' }
    let(:user) { create(:user, name: user_name) }

    it 'succeeds' do
      get user_path(user)
      expect(response.status).to eq 200
    end

    it 'displays name of user' do
      get user_path(user)
      expect(response.body).to include user_name
    end
  end
end
