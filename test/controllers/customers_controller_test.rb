require 'test_helper'

class CustomersControllerTest < ActionController::TestCase
  def setup
    @customer = customers(:test_customer)
    @foobar = customers(:foobar)
  end

  test "should redirect to login when not logged in" do
    get :edit, id: @customer
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch :update, id: @customer, customer: { name: @customer.name, email: @customer.email }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect to root when updating a different customer's profile" do
    log_in_as(@customer, { password: 'foobar' })
    get :edit, id: @foobar
    assert_not flash.empty?
    assert_redirected_to root_url
  end
end
