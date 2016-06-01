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

  test 'successful edit should redirect to profile page' do
    log_in_as(@customer, { password: 'foobar' })
    get edit_customer_path(@customer)
    assert_template 'customers/edit'
    patch customer_path(@customer), customer: { name: 'Christopher',
                                                email: 'cjv287@gmail.com',
                                                password: 'foobarbaz',
                                                password_confirmation: 'foobarbaz' }
    #Need to go back to earlier chapters and write shared errors for
    #invalidated customer objects.
    assert_not flash.empty?
    # assert_redirected_to @customer
    # @customer.reload
    # assert_equal 'CJ', @customer.name
    # assert_equal 'cjv287@gmail.com', @customer.email
  end
end
