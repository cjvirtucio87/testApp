class CustomersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :all]
  before_action :correct_profile, only: [:edit, :update]
  before_action :admin_user, only: [:all]

  def index
    #Declare @customer only if an id is among the query parameters.
    @customer = Customer.find(params[:id]) if params[:id]
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def all
    @customers = Customer.paginate(page: params[:page])
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
    @customer = Customer.find(params[:id])
    if @customer.update_attributes(permitParams)
      flash.now[:success] = "Profile updated"
      redirect_to @customer
    else
      flash.now[:danger] = "Error: profile not updated"
      render 'edit'
    end
  end

  def destroy
    @customer = Customer.find(params[:id])
    if current_customer.admin?
      @customer.destroy
      redirect_to customers_path
    else
      flash.now[:danger] = 'You are not the admin. Please log in as admin user.'
      redirect_to login_path
    end
  end

  def logged_in_user
    unless logged_in?
      store_forwarding_url
      flash[:danger] = 'Please log in.'
      redirect_to login_url
    end
  end

  def correct_profile
    @customer = Customer.find(params[:id])
    unless current_customer?(@customer)
      flash[:danger] = 'Cannot edit other users\' profiles.'
      redirect_to(root_url)
    end
  end

  private
    def permitParams
      permissibleParams = [ :name, :email, :password, :password_confirmation ]
      permittedParams = params.require(:customer).permit(permissibleParams)
    end

    def admin_user
      redirect_to(root_url) unless current_customer.admin?
    end
end
