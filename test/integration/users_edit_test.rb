require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @customer = customers(:test_customer)
  end

  test 'unsuccessful edit should re-render edit view' do
    log_in_as(@customer, { password: 'foobar' })
    get edit_customer_path(@customer)
    assert_template 'customers/edit'
    patch customer_path(@customer), customer: { password: 'meh',
                                                password_confirmation: 'meh' }
    assert_template 'customers/edit'
  end
end
