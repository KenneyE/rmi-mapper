class LocationsController < ApplicationController
  def index
    @locations = current_user.locations
    @center = Location.find_center(@locations)
  end

  def search
    fail
  end
end
