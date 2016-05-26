class CustomersController < ApplicationController
  def index
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(params[:customer])
    @customer.save ? redirect_to @customer : render 'new'
  end

  def edit
  end

  def destroy
  end
end
