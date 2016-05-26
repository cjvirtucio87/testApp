class CustomersController < ApplicationController
  def index
  end

  def show
    @customers = Customer.all
  end

  def new
    @customer = Customer.new
  end

  def create
    permitCustomerParams = params.require(:customer).permit(:name, :email)
    @customer = Customer.new(permitCustomerParams)
    if @customer.save 
      redirect_to @customer
    else
      render 'new'
    end
  end

  def edit
  end

  def destroy
  end
end
