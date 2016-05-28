module SessionsHelper
  def log_in(customer)
    session[:customer_id] = customer.id
  end

  def current_customer
    @current_customer ||= Customer.find_by(id: session[:customer_id])
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
