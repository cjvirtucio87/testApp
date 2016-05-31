require 'test_helper'

class SignupTest < ActionDispatch::IntegrationTest
  def setup
    @customer_hash = { name: 'Jewel',
                       email: 'jewel@gmail.com',
                       password: 'jewelfoobar',
                       password_confirmation: 'jewelfoobar'
    }
  end

  test 'should add a new user to the database' do
    get customers_new_path
    assert_difference 'Customer.count', 1 do
      post_via_redirect customers_path, customer: @customer_hash
    end
    assert_template 'customers/show'
  end
end
