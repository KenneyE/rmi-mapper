class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    @locations = @user.locations
  end
end
