class SessionsController < ApplicationController
  def new
  end

  def create
    customer = Customer.find_by(email: params[:session][:email].downcase)
    if customer && customer.authenticate(params[:session][:password])
      log_in customer
      make_cookies customer
      #redirect_to makes a new request, unlike render.
      redirect_to customer, notice: 'You are now logged in.'
    else
      flash.now[:danger] = 'Invalid email/password combination!'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url, notice: 'You have logged out.'
  end
end
