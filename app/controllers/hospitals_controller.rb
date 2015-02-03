class HospitalsController < ApplicationController
  before_action :authenticate_admin!, only: [:new, :create]

  def index
    @features = Feature.all.select(:name)
    @hospitals = Hospital.all
    @center = Location.find_center(@hospitals)
  end

  def new
    @hospital = Hospital.new()
  end

  def create
  end

  def search
    @features = params[:features].nil? ? Feature.all.select(:name) : params[:features]

    @location = Location.find(params[:location_id])
    @hospitals = Hospital.find_nearby_with_features(@location.lat, @location.lon, @features)

    # @hospitals = Hospital.joins(:features).where(features: {name: @features} )
    if @hospitals.empty?
      flash.now[:notices] = ["No hospitals matched filters"]
    end
    render :index
  end
end
