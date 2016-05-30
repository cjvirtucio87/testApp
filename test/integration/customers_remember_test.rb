require 'test_helper'

class CustomersRememberTest < ActionDispatch::IntegrationTest
  def setup
    @customer = @customers[:test_customer]
  end

  test 'cookies object should contain encrypted customer id' do
    get login_path
    post login_path, session: { email: @customer.email, password: @customer.password }
    assert_template 'sessions/new'
  end
end
