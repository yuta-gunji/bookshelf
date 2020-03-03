# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'noreply@' + (ENV['DOMAIN_NAME'] || 'example.com')
  layout 'mailer'
end
