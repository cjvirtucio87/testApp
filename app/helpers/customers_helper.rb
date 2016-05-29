module CustomersHelper

  def logged_in_link
    loginLink = lambda { link_to 'Log in', login_path }
    logoutLink = lambda do 
      link_to 'destroy', customer_path(@customer),
                        method: :delete, 
                        data: { confirm: 'Are you sure?' }
    end
    logged_in? ? logoutLink : loginLink
  end
end
