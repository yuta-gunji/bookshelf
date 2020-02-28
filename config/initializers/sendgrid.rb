# frozen_string_literal: true

ActionMailer::Base.smtp_settings = {
  user_name: ENV['SENDGRID_USER_NAME'],
  password: ENV['SENDGRID_PASSWORD'],
  domain: ENV['DOMAIN_NAME'],
  address: 'smtp.sendgrid.net',
  port: 587,
  authentication: :plain,
  enable_starttls_auto: true
}
