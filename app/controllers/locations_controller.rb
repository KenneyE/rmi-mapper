class LocationsController < ApplicationController

  def create
    location = Location.new(location_params)
    if location.save!
      location.user_locations.create(user_id: current_user.id, location_id: location.id)
      flash[:notices] = ["Location '#{location.name}' successfully created!"]
      redirect_to current_user
    else
      flash.now[:errors] = location.errors.full_messages
      render current_user
    end
  end

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

  private
  def location_params
    params.require(:location).permit(:name, :lat, :lon, :location_type)
  end
end
