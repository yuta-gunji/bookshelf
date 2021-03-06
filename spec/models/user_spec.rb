# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    let(:user) { build(:user) }

    context 'when valid user' do
      it { expect(user).to be_valid }
    end

    context 'without name' do
      let(:invalid_user) { build(:user, name: '') }
      it { expect(invalid_user).not_to be_valid }
    end

    context 'without email' do
      let(:invalid_user) { build(:user, email: '') }
      it { expect(invalid_user).not_to be_valid }
    end

    context 'when email does not unique' do
      let(:user) { create(:user) }
      let(:duplicate_user) { user.dup }
      before { duplicate_user.email = user.email.upcase }
      it { expect(duplicate_user).not_to be_valid }
    end

    context 'when input email has upper-case' do
      let(:mixed_case_email) { 'Foo@ExAMPle.CoM' }
      before do
        user.email = mixed_case_email
        user.save
      end
      it { expect(user.email).to eq mixed_case_email.downcase }
    end

    context 'when email address is valid ' do
      valid_addresses = %w[
        user@example.com
        USER@foo.COM
        A_US-ER@foo.bar.org
        first.last@foo.jp
        alice+bob@baz.cn
      ]

      valid_addresses.each do |valid_address|
        before { user.email = valid_address }
        it { expect(user).to be_valid }
      end
    end

    context 'when email address is invalid' do
      invalid_addresses = %w[
        user@example,com
        user_at_foo.org
        user.name@example.
        foo@bar_baz.com
        foo@bar+baz.com
        foo@bar..com
      ]

      invalid_addresses.each do |invalid_address|
        before { user.email = invalid_address }
        it { expect(user).not_to be_valid }
      end
    end

    context 'without password' do
      let(:invalid_user) { build(:user, password: '') }
      it { expect(invalid_user).not_to be_valid }
    end

    context 'when password is shorter than minimum length' do
      let(:invalid_user) { build(:user, password: 'a' * 5) }
      it { expect(invalid_user).not_to be_valid }
    end

    context 'when password is just minimum length' do
      let(:valid_user) { build(:user, password: 'a' * 6) }
      it { expect(valid_user).to be_valid }
    end
  end

  describe '.digest' do
    encrypted_password = User.digest('password')
    it { expect(encrypted_password).to be_an_instance_of(BCrypt::Password) }
  end

  describe '.new_token' do
    it { expect(User.new_token).to be_an_instance_of(String) }
  end

  describe '#remember' do
    let(:user) { create(:user) }
    before { user.remember }
    it { expect(user.remember_digest).to be_truthy }
  end

  describe '#authenticated?' do
    context 'when remember_digest exists' do
      let(:remember_token) { new_token }
      let(:user_with_digest) { create(:user, remember_digest: digest(remember_token)) }
      it { expect(user_with_digest.authenticated?(:remember, remember_token)).to be_truthy }
    end

    context 'when remember_digest is empty' do
      let(:remember_token) { new_token }
      let(:user_without_digest) { create(:user, remember_digest: nil) }
      it { expect(user_without_digest.authenticated?(:remember, remember_token)).to be_falsey }
    end
  end

  describe '#forget' do
    let(:user) { create(:user, remember_digest: digest(new_token)) }
    before { user.forget }
    it { expect(user.remember_digest).to be_falsey }
  end

  describe '#activate' do
    let(:user) { create(:user, activated: false, activated_at: nil) }
    it { expect { user.activate }.to change { user.activated }.from(false).to(true) }
  end

  describe '#create_reset_digest' do
    let(:user) { create(:user, reset_digest: nil, reset_sent_at: nil) }
    it { expect { user.create_reset_digest }.to change { user.reset_digest }.from(be_falsey).to(be_truthy) }
  end

  describe '#follow' do
    let(:user) { create(:user) }
    let(:another_user) { create(:user) }
    it 'user can follow another user' do
      expect(user.followings.count).to eq 0
      expect { user.follow(another_user) }.to change { user.followings.count }.by(1)
    end
  end

  describe '#unfollow' do
    let(:user) { create(:user) }
    let(:another_user) { create(:user) }
    before { create(:relationship, follower_id: user.id, followed_id: another_user.id) }
    it 'user can unfollow another user' do
      expect { user.unfollow(another_user) }.to change { user.followings.count }.by(-1)
    end
  end

  describe '#following?' do
    let(:user) { create(:user) }
    let(:another_user) { create(:user) }
    before { create(:relationship, follower_id: user.id, followed_id: another_user.id) }
    it { expect(user.following?(another_user)).to be_truthy }
  end
end
