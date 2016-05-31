class CustomersController < ApplicationController
  def index
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def all
    @customers = Customer.all
  end

  def new
    @customer = Customer.new
  end

  def create
    #Whitelist fields.
    permitCustomerParams = params.require(:customer).permit(:name, :email, :password)
    @customer = Customer.new(permitCustomerParams)
    if @customer.save 
      redirect_to @customer
    else
      render 'new'
    end
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    permitCustomerParams = params.require(:customer).permit(:name, :email, :password)
    @customer = Customer.find(params[:id])
    if @customer.update(permitCustomerParams)
      redirect_to @customer
    else
      render 'edit'
    end
  end

  def destroy
    @customer = Customer.find(params[:id])
    @customer.destroy
    redirect_to customers_path
  end
end
