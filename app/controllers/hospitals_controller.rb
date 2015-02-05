class HospitalsController < ApplicationController
  before_action :authenticate_admin!, only: [:new, :create]

  def index
    @features = Feature.all
    @hospitals = Hospital.all
    @center = Location.find_center(@hospitals)
  end

  def new
    @features = Feature.all
    @selected_features = []
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
    @features = Feature.all
    @selected_features = []

    if params[:features].nil?
      @hospitals = Hospital.find_nearby_with_features(@location.lat, @location.lon, [])
    else
      @selected_features = params[:features]
      @hospitals = Hospital.find_nearby_with_features(@location.lat, @location.lon, @selected_features)
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
