module CustomersHelper
  def logged_in_link(customer)
    loginLink = lambda { link_to 'Log in', login_path }
    profileLink = lambda { link_to 'Profile', profile_path }
    logged_in? ? logoutLink : loginLink
  end
end
