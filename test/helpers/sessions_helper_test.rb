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
end
