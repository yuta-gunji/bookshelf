# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'PasswordResets', type: :request do
  let(:user) { create(:user) }

  describe 'GET #new' do
    it 'succeeds' do
      get new_password_reset_path
      expect(response.status).to eq 200
    end
  end

  describe 'POST #create' do
    context 'when input email is exists' do
      it 'succeeds with redirect' do
        post password_resets_path, params: { password_reset: { email: user.email } }
        expect(response.status).to eq 302
        expect(response).to redirect_to login_path
      end
    end

    context 'when input email is not exists' do
      it 'fails with error message' do
        post password_resets_path, params: { password_reset: { email: 'not_registered@example.com' } }
        expect(response.body).to include I18n.t(:email_address_not_found)
      end
    end
  end

  describe 'GET #edit' do
    before { user.create_reset_digest }

    context 'with correct token and email' do
      it 'succeeds' do
        get edit_password_reset_path(user.reset_token, email: user.email)
        expect(response.status).to eq 200
      end
    end

    context 'with incorrect token' do
      it 'fails with redirect' do
        get edit_password_reset_path('incorrect_token', email: user.email)
        expect(response.status).to eq 302
        expect(response).to redirect_to login_path
      end
    end

    context 'with incorrect email' do
      it 'raises exception' do
        expect { get edit_password_reset_path(user.reset_token, email: '') }.to raise_error ActiveRecord::RecordNotFound
      end
    end

    context 'when link is expired' do
      before { user.update_attribute(:reset_sent_at, 25.hours.ago) }

      it 'fails with redirect' do
        get edit_password_reset_path(user.reset_token, email: user.email)
        expect(response.status).to eq 302
        expect(response).to redirect_to new_password_reset_path
      end
    end

    context 'when user is not activated' do
      before { user.update_attribute(:activated, false) }

      it 'fails with redirect' do
        get edit_password_reset_path(user.reset_token, email: user.email)
        expect(response.status).to eq 302
        expect(response).to redirect_to login_path
      end
    end
  end

  describe 'PATCH #update' do
    let(:new_password) { 'new_password' }
    let(:another_password) { 'another_password' }
    before { user.create_reset_digest }

    it 'succeeds with redirect' do
      patch password_reset_path(user.reset_token), params: {
        email: user.email,
        password_reset: {
          password: new_password,
          password_confirmation: new_password
        }
      }
      expect(response.status).to eq 302
      expect(response).to redirect_to user_path(user)
    end

    context 'when there is mismatch between password and password_confirmation' do
      it 'fails with error message' do
        patch password_reset_path(user.reset_token), params: {
          email: user.email,
          password_reset: {
            password: new_password,
            password_confirmation: another_password
          }
        }
        expect(response.body).to include 'パスワード(確認)とパスワードの入力が一致しません'
      end
    end

    context 'when link is expired' do
      before { user.update_attribute(:reset_sent_at, 25.hours.ago) }

      it 'fails with redirect to new_password_reset_path' do
        patch password_reset_path(user.reset_token), params: {
          email: user.email,
          password_reset: {
            password: new_password,
            password_confirmation: new_password
          }
        }
        expect(response.status).to eq 302
        expect(response).to redirect_to new_password_reset_path
      end
    end
  end
end
