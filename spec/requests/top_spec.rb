# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Top', type: :request do
  describe 'GET #index' do
    it 'succeeds' do
      get root_path
      expect(response.status).to eq 200
    end
  end
end
