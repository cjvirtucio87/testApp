require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @customer = customers(:test_customer)
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
    get edit_customer_path(@customer)
    patch customer_path(@customer), customer: { email: 'foobarbaz@foobarmail.com' }
    assert success_flash
  end
end
