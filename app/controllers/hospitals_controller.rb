class HospitalsController < ApplicationController
  before_action :authenticate_admin!, only: [:new, :create]

  def index
    @features = Feature.all.select(:name)
    @hospitals = Hospital.all
    @center = Location.find_center(@hospitals)
  end

  def new
    @features = Feature.all
  end

  def create
    hospital = Hospital.new(hospital_params)

    if hospital.save!
      flash[:notices] = ["Hospital, #{hospital.name}, created!"]
      redirect_to :new_hospital
    else
      flash.now[:errors] = hospital.errors.full_messages
      render :new
    end
  end

  def search

    @location = Location.find(params[:location_id])

    if params[:features].nil?
      @features = Feature.all.select(:name)
      @hospitals = Hospital.find_nearby_with_features(@location.lat, @location.lon, [])
    else
      @features = params[:features]
      @hospitals = Hospital.find_nearby_with_features(@location.lat, @location.lon, @features)
    end

    # @hospitals = Hospital.joins(:features).where(features: {name: @features} )
    if @hospitals.empty?
      flash.now[:notices] = ["No hospitals matched filters"]
    end
    render :index
  end

  private
  def hospital_params
    params.require(:hospital).permit(:name, :features, :lat, :lon, :description)
  end
end
