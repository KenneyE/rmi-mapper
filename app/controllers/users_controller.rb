class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin!, only: [:new_admin, :create_admin]
  def show
    @user = current_user
    @locations = @user.locations
  end

  def new_admin
  end

  def create_admin
    @user = User.find_by(email: params[:email])

    unless @user.nil?
      if @user.admin?
        flash[:notices] = ["#{@user.email} is already an admin."]
      else
        @user.admin = true
        flash[:notices] = ["Admin privilidges granted to #{@user.email}."]
      end
    else
      flash[:errors] = ["#{params[:email]} not found!"]
    end
    redirect_to :new_admin
  end
end
