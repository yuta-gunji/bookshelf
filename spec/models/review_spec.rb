# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Review, type: :model do
  context 'when valid book' do
    let(:review) { build(:review) }
    it { expect(review).to be_valid }
  end

  context 'without title' do
    let(:invalid_review) { build(:review, title: '') }
    it { expect(invalid_review).not_to be_valid }
  end

  context 'without content' do
    let(:invalid_review) { build(:review, content: '') }
    it { expect(invalid_review).not_to be_valid }
  end

  context 'without rate' do
    let(:invalid_review) { build(:review, rate: '') }
    it { expect(invalid_review).not_to be_valid }
  end

  context 'when rate is not integer' do
    let(:invalid_review) { build(:review, rate: 0.5) }
    it { expect(invalid_review).not_to be_valid }
  end

  context 'when user_id does not exist' do
    let(:invalid_review) { build(:review, user_id: '') }
    it { expect(invalid_review).not_to be_valid }
  end

  context 'when book_id does not exist' do
    let(:invalid_review) { build(:review, book_id: '') }
    it { expect(invalid_review).not_to be_valid }
  end

  context 'when reviewed_at does not exist' do
    let(:invalid_review) { build(:review, reviewed_at: nil) }
    it { expect(invalid_review).not_to be_valid }
  end
end
