class LocationsController < ApplicationController
  def index
    @locations = current_user.locations
  end
end
