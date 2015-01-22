class HospitalsController < ApplicationController
  def index
    @features = Feature.all.select(:name)
    @hospitals = Hospital.all
    @center = Location.find_center(@hospitals)
  end

  def search
    @features = params[:features].nil? ? Feature.all.select(:name) : params[:features]

    @location = Location.find(params[:location_id])
    Hospital.find_nearby_with_features(@location.lat, @location.lon, @features)

    @hospitals = Hospital.joins(:features).where(features: {name: @features} )
    if @hospitals.empty?
      @hospitals = current_user.locations
      flash.now[:notices] = ["No locations matched filters"]
    end
    render :index
  end
end
