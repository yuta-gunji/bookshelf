# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }
  let(:mixed_case_email) { 'Foo@ExAMPle.CoM' }

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
      before do
        user.save
      end

      it {
        duplicate_user = user.dup
        duplicate_user.email = user.email.upcase
        expect(duplicate_user).not_to be_valid
      }
    end

    context 'when input email has upper-case' do
      before do
        user.email = mixed_case_email
        user.save
      end

      it { expect(user.email).to eq mixed_case_email.downcase }
    end

    context 'when email addresse is valid ' do
      valid_addresses = %w[
        user@example.com
        USER@foo.COM
        A_US-ER@foo.bar.org
        first.last@foo.jp
        alice+bob@baz.cn
      ]

      valid_addresses.each do |valid_address|
        it {
          user.email = valid_address
          expect(user).to be_valid
        }
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
        it {
          user.email = invalid_address
          expect(user).not_to be_valid
        }
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
end
