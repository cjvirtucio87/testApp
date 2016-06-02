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
      #Forward to either stored url (if any) or the passed default.
      friendly_forward(@customer)
    else
      flash.now[:danger] = 'Invalid email/password combination!'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    flash.now[:success] = 'You have logged out.'
    redirect_to root_url
  end
end
