# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Relationship, type: :model do
  context 'when valid' do
    let(:relationship) { build(:relationship) }
    it { expect(relationship).to be_valid }
  end

  context 'without followed_id' do
    let(:invalid_relationship) { build(:relationship, followed_id: '') }
    it { expect(invalid_relationship).not_to be_valid }
  end

  context 'without follower_id' do
    let(:invalid_relationship) { build(:relationship, follower_id: '') }
    it { expect(invalid_relationship).not_to be_valid }
  end

  context 'when follow yourself' do
    let(:user) { create(:user) }
    let(:invalid_relationship) { build(:relationship, follower_id: user.id, followed_id: user.id) }
    it { expect(invalid_relationship).not_to be_valid }
  end
end
