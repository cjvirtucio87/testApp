module SessionsHelper
  def log_in(customer)
    session[:customer_id] = customer.id
  end

  def current_customer
    @current_customer ||= Customer.find_by(id: session[:customer_id])
  end
end
