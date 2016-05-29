require 'test_helper'

class CustomersLoginTest < ActionDispatch::IntegrationTest
  test "login successfully" do
    get login_path
    assert_template 'sessions/new'
    post login_path, session: { email: 'virtucio.cj@gmail.com', password: 'foobar' }
    assert_template 'sessions/new'
    assert_not flash.empty?
  end

  test "login with an invalid password" do
    get login_path
    assert_template 'sessions/new'
    post login_path, session: { email: 'virtucio.cj@gmail.com', password: 'barbaz' }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "login, go to the homepage, 'login' should appear as 'logout'" do
    get login_path
    post login_path, session: { email: 'virtucio.cj@gmail.com', password: 'foobar' }
    get root_path
    assert logged_in?
  end
end
