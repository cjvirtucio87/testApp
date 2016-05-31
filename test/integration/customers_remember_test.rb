require 'test_helper'

class CustomersRememberTest < ActionDispatch::IntegrationTest

  def setup
    @customer = customers(:test_customer)
  end
  
  test 'should have a cookie set to remember the customer' do
    log_in_as(@customer, { password: 'foobar', remember_me: '1' })
    assert_not_nil cookies['remember_token']
  end

  test "should have customer's remember_token" do
    log_in_as(@customer, { password: 'foobar', remember_me: '1' })
    assert_equal true, assigns(:customer).authenticated?(cookies['remember_token'])
  end
end
