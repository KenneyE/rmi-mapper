class HospitalsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin!, only: [:new, :create]

  def index
    @features = Feature.all.order(:name)
    @hospitals = Hospital.all
    @center = Location.find_center(@hospitals)
  end

  def new
    @features = Feature.all.order(:name)
    @selected_features = []
  end

  def create
    hospital = Hospital.new(hospital_params)

    if hospital.save!
      params[:features].each do |feature|
        hospital.hospital_features.create(hospital_id: hospital.id, feature_id: feature.to_i)
      end
      flash[:notices] = ["Hospital, #{hospital.name}, created!"]
      redirect_to :new_hospital
    else
      flash.now[:errors] = hospital.errors.full_messages
      render :new
    end
  end

  def search
    @location = Location.find(params[:location_id])
    update_location = params[:refresh] == "true" && @location.location_type == "ship"
    successful_update = @location.get_marine_traffic_location! if update_location
    @features = Feature.all.order(:name)
    @selected_features = []

    if params[:features].nil?
      @hospitals = Hospital.find_nearby_with_features(@location.lat, @location.lon, [])
    else
      @selected_features = params[:features]
      @hospitals = Hospital.find_nearby_with_features(@location.lat, @location.lon, @selected_features)
    end

    if @hospitals.empty?
      flash.now[:notices] = ["No hospitals matched filters"]
    elsif update_location && successful_update
      flash.now[:notices] = ["Succesfully updated ship location"]
    elsif update_location && !successful_update
      flash.now[:notices] = ["Unable to update ship location!"]
    end
    render :index
  end

  private
  def hospital_params
    params.require(:hospital).permit(:name, :lat, :lon, :description)
  end
end
