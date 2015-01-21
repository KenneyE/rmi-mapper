class LocationsController < ApplicationController
  def index
    @features = Feature.all.select(:name)
    @locations = current_user.locations
    @center = Location.find_center(@locations)
  end

  def search
    @features = params[:features].nil? ? Feature.all.select(:name) : params[:features]
    @locations = Location.joins(:features).where(features: {name: @features} )
    if @locations.empty?
      @locations = current_user.locations
      flash.now[:notices] = ["No locations matched filters"]
    end
    @center = Location.find_center(@locations)
    render :index
  end
end
