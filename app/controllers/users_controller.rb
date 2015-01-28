class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin!, only: [:new_admin]
  def show
    @user = current_user
    @locations = @user.locations
  end

  def new_admin
    @user = User.new()
  end

  private
  def authenticate_admin!
    unless current_user.admin?
      redirect_to current_user
    end
  end
end
