module CustomersHelper
  def logged_in_link
    loginLink = lambda { link_to 'Log in', login_path }
    profileLink = lambda { link_to 'Profile', customers_show_path(@current_customer) }
    logged_in? ? profileLink : loginLink
  end
end
