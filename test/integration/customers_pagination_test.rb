require 'test_helper'

class CustomersPaginationTest < ActionDispatch::IntegrationTest
  def setup
    @customer = customers(:test_customer)
  end

  test 'all including pagination' do
    log_in_as(@customer, password: 'foobar')
    get customers_all_path
    assert_template 'customers/all'
    assert_select 'div.pagination'
    Customer.paginate(page: 1).each do |customer|
      assert_select 'li', text: customer.name
    end
  end
end
