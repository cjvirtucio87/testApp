module CustomersHelper
  def logged_in_link(customer)
    loginLink = -> { link_to 'Log in', login_path }
    profileLink = -> (cust) { link_to 'Profile', cust }
    logged_in? ? profileLink.call(customer) : loginLink.call
  end
end
