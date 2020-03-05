# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Like, type: :model do
  context 'when valid like' do
    let(:like) { build(:like) }
    it { expect(like).to be_valid }
  end

  context 'without review_id' do
    let(:invalid_like) { build(:like, review_id: '') }
    it { expect(invalid_like).not_to be_valid }
  end

  context 'without user_id' do
    let(:invalid_like) { build(:like, user_id: '') }
    it { expect(invalid_like).not_to be_valid }
  end

  context 'when like twice' do
    let(:invalid_like) { build(:like, user_id: @like.user_id, review_id: @like.review_id) }
    before { @like = create(:like) }

    it { expect(invalid_like).not_to be_valid }
  end
end
