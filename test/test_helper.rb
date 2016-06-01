ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def is_logged_in?
    !session[:customer_id].nil?
  end

  def log_in_as(customer, options = {})
    password = options[:password] || 'password'
    remember_me = options[:remember_me] || '1'
    customer_hash = { email: customer.email, 
                      password: password,
                      password_confirmation: password,
                      remember_me: remember_me }
    post_login = -> { post login_path, session: customer_hash }
    new_session = -> { session[:customer_id] = customer.id }
    integration_test? ? post_login.call : new_session.call
  end

  def danger_flash
    flash.keys.any? { |key| key == 'danger' }
  end

  def success_flash
    flash.keys.any? { |key| key == 'success' }
  end

  private
  
  def integration_test?
    defined?(post_via_redirect)
  end
end
