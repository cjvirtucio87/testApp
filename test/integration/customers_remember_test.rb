require 'test_helper'

class CustomersRememberTest < ActionDispatch::IntegrationTest
  def setup
    @customer = @customers[:test_customer]
  end
end
