require 'test_helper'

class CustomerTest < ActiveSupport::TestCase
  def setup
    @customer = Customer.new(name: 'tester', email: 'tester@testmail.com', password: 'foobar', password_confirmation: 'foobar')
  end

  def

  test 'should authenticate' do
    @customer.password = 'foobar'
    assert @customer.valid?
  end

  test 'should not authenticate for wrong password input' do
    @customer.password = 'torrentz'
    assert_not @customer.valid?
  end
end
