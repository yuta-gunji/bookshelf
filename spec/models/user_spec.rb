# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  describe 'validations' do
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
      before do
        duplicate_user.email = user.email.upcase
      end
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
        before do
          user.email = valid_address
        end
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
        before do
          user.email = invalid_address
        end
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
    before do
      user.remember
    end
    it { expect(user.remember_digest).to be_truthy }
  end

  describe '#authenticated?' do
    context 'when remember_digest exists' do
      let(:remember_token) { new_token }
      let(:user_with_digest) { create(:user, remember_digest: digest(remember_token)) }
      it { expect(user_with_digest.authenticated?(remember_token)).to be_truthy }
    end

    context 'when remember_digest is empty' do
      let(:remember_token) { new_token }
      let(:user_without_digest) { create(:user, remember_digest: nil) }
      it { expect(user_without_digest.authenticated?(remember_token)).to be_falsey }
    end
  end

  describe '#forget' do
    let(:user) { create(:user, remember_digest: digest(new_token)) }
    before do
      user.forget
    end
    it { expect(user.remember_digest).to be_falsey }
  end
end
