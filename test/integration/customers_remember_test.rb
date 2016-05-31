require 'test_helper'

class CustomersRememberTest < ActionDispatch::IntegrationTest

  def setup
    @customer = customers(:test_customer)
  end
  
  test 'should have a cookie set to remember the customer' do
    log_in_as(@customer, { password: 'foobar', remember_me: '1' })
    assert_not_nil cookies['remember_token']
  end
end
