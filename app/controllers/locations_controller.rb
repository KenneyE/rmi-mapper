class LocationsController < ApplicationController
  def index
    @locations = current_user.locations
    @center = Location.find_center(@locations)
  end

  def search
    @locations = Location.joins(:features).where(features: {name: params[:features]} )
    @center = Location.find_center(@locations)
    render :index
  end
end
