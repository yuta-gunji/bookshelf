# frozen_string_literal: true

ActionMailer::Base.add_delivery_method :sendgrid, Mail::SendGrid, api_key: ENV.fetch('SENDGRID_API_KEY')
