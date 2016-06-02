require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @customer = customers(:test_customer)
    @foobar = customers(:foobar)
    @login_params = { email: @customer.email, 
                      password: 'foobar',
                      password_confirmation: 'foobar' }
  end

  test 'unsuccessful edit' do
    log_in_as(@customer, { password: 'foobar' })
    get edit_customer_path(@customer)
    patch customer_path(@customer), customer: { name:  "",
                                    email: "foo@invalid",
                                    password:              "foo",
                                    password_confirmation: "bar" }
    assert_template 'customers/edit'
  end

  test 'successful edit' do
    log_in_as(@customer, { password: 'foobar' })
    assert success_flash
    get edit_customer_path(@customer)
    patch customer_path(@customer), customer: { email: 'foobarbaz@foobarmail.com' }
    assert success_flash
  end

  test "should redirect to root when editting a different customer's profile" do
    log_in_as(@customer, { password: 'foobar' })
    assert success_flash
    get edit_customer_path(@foobar)
    assert_redirected_to root_url
  end

  test 'successful edit with friendly forwarding' do
    get edit_customer_path(@customer)
    log_in_as(@customer, { password: 'foobar' })
    assert_redirected_to edit_customer_path(@customer)
    delete logout_path @customer
    assert success_flash
    assert_redirected_to root_url
    log_in_as(@customer, { password: 'foobar' })
    assert_redirected_to @customer
  end

  test 'should display proper layout links' do
    log_in_as(@customer, { password: 'foobar' })
    assert success_flash
    assert_redirected_to @customer
    assert_template customer_path(@customer)
  end

end
