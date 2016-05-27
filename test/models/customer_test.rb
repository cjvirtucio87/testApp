require 'test_helper'

class CustomerTest < ActiveSupport::TestCase
  def setup
    @customer = Customer.new(name: 'tester', email: 'tester@testmail.com', password: 'foobar', password_confirmation: 'foobar')
  end

  test 'should authenticate' do
    @customer.password = 'torrential'
    assert_not @customer.valid?
  end
end
