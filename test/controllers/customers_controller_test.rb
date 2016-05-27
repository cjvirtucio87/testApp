require 'test_helper'

class CustomersControllerTest < ActionController::TestCase
  def setup
    @customer = Customer.new(id: 1, name: 'tester', email: 'test@testmail.com', 
                                                    password: 'testword',
                                                    password_confirmation: 'testword')
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end


end
