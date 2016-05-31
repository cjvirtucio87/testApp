require 'test_helper'

class SessionsHelperTest < ActionView::TestCase
  def setup
    @customer = customers(:test_customer)
    make_cookies(@customer)
  end

  test 'should remember the customer' do
    assert_equal @customer, current_customer
    assert is_logged_in?
  end

  test 'current_customer returns nil when remember _token and _digest mismatch ' do
    @customer.update_attribute(:remember_digest,Customer.digest(Customer.new_token))
    assert_nil current_customer
  end
end
