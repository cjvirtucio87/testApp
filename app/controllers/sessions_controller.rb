class SessionsController < ApplicationController
  def new
  end

  def create
    @customer = Customer.find_by(email: params[:session][:email].downcase)
    if @customer && @customer.authenticate(params[:session][:password])
      log_in @customer
      remember_me = params[:session][:remember_me]
      remember_me == '1' ? make_cookies(@customer) : forget(@customer)
      flash.now[:success] = 'You are now logged in.'
      #redirect_to makes a new request, unlike render.
      friendly_forward(@customer)
    else
      flash.now[:danger] = 'Invalid email/password combination!'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url, success: 'You have logged out.'
  end
end
