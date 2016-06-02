require 'test_helper'

class CustomersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @customer = customers(:test_customer)
    @login_params = { email: @customer.email, 
                      password: 'foobar',
                      password_confirmation: 'foobar' }
  end

  test "login successfully" do
    get login_path
    assert_template 'sessions/new'
    post login_path, session: @login_params
    assert success_flash
  end

  test "login with an invalid password" do
    get login_path
    assert_template 'sessions/new'
    post login_path, session: { email: @customer.email, 
                                password: 'barbaz',
                                password: 'barbaz' }
    assert_template 'sessions/new'
    assert danger_flash
    get root_path
    assert flash.empty?
  end

  test "login, go to the homepage, 'login' should appear as 'profile'" do
    get login_path 
    post login_path, session: @login_params
    assert success_flash
    get root_path
    #Assert that an <a> element with a login path does not appear.
    assert_select "a[href=?]", login_path, count: 0
    #Assert that an <a> element with a customers#show path appears.
    assert_select "a[href=?]", customer_path(@customer), count: 1
  end
  
end
