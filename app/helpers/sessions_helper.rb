module SessionsHelper
  def log_in(customer)
    session[:customer_id] = customer.id
  end

  def current_customer
    if customer_id = session[:customer_id]
      @current_customer ||= Customer.find_by(id: session[:customer_id])
    elsif customer_id = cookies.signed[:customer_id]
      customer = Customer.find_by(id: customer_id)
      if customer && customer.authenticate(cookies[:remember_token])
        log_in customer
        @current_customer = customer
      end
    end
  end

  def forget(customer)
    customer.forget
    cookies.delete(:customer_id)
    cookies.delete(:remember_token)
  end

  def log_out
    forget(current_customer)
    session.delete(:customer_id)
    @current_customer = nil
  end

  def logged_in?
    !session[:customer_id].nil?
  end

  def make_cookies(customer)
    customer.remember
    cookies.permanent.signed[:customer_id] = customer.id
    cookies.permanent[:remember_token] = customer.remember_token
  end
end
