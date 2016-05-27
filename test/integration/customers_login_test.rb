require 'test_helper'

class CustomersLoginTest < ActionDispatch::IntegrationTest
  test "login with an invalid password" do
    get login_path
    assert_template 'sessions/new'
    post login_path, session: { email: 'virtucio.cj@gmail.com', password: 'barbaz' }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end  
end
