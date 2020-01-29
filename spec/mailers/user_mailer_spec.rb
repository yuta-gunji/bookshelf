# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  describe 'account_activation' do
    let(:user) { create(:user) }
    let(:mail) { UserMailer.account_activation(user) }

    it 'renders the headers' do
      expect(mail.subject).to eq(I18n.t(:account_activation))
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(['noreply@example.com'])
    end
  end

  describe 'password_reset' do
    let(:user) { create(:user) }
    let(:mail) { UserMailer.password_reset(user) }

    before do
      user.reset_token = User.new_token
    end

    it 'renders headers' do
      expect(mail.subject).to eq(I18n.t(:password_reset))
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(['noreply@example.com'])
    end

    it 'renders body' do
      expect(mail.body.parts.collect(&:content_type)).to include 'text/html; charset=UTF-8', 'text/plain; charset=UTF-8'
      expect(mail.body.parts.find { |p| p.content_type.match(/html/) }.body.raw_source).to match(user.reset_token)
      expect(mail.body.parts.find { |p| p.content_type.match(/html/) }.body.raw_source).to match(CGI.escape(user.email))
      expect(mail.body.parts.find { |p| p.content_type.match(/plain/) }.body.raw_source).to match(user.reset_token)
      expect(mail.body.parts.find { |p| p.content_type.match(/plain/) }.body.raw_source).to match(CGI.escape(user.email))
    end
  end
end
