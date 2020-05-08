module Emailnet
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    before_action :http_authenticate

    def http_authenticate
      return true unless Rails.env == 'production'
      authenticate_or_request_with_http_basic do |username, password|
        username == 'username' && password == ENV['DEV_PASSWORD']
      end
    end
  end
end
