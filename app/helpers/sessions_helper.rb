module SessionsHelper
  def log_in(customer)
    session[:customer_id] = customer.id
  end

  def current_customer
    #when in session
    if customer_id = session[:customer_id]
      @current_customer ||= Customer.find_by(id: customer_id)
    #when not in session, use cookie
    elsif customer_id = cookies.signed[:customer_id]
      customer = Customer.find_by(id: customer_id)
      #login if remember_token cookie matches customer's remember_digest
      if customer && customer.authenticated?(cookies[:remember_token])
        log_in customer
        @current_customer = customer
      end
    end
  end

  def current_customer?(customer)
    customer == current_customer
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

  def friendly_foward(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  def store_forwarding_url
    session[:forwarding_url] = request.url if request.get?
  end
end
