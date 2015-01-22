class Hospital < ActiveRecord::Base
  validates :name, presence: true

  has_many :hospital_features
  has_many :features, through: :hospital_features

  def self.find_center(locations)
    {lat: locations.average("lat"), lon: locations.average("lon")}
  end

  def self.find_nearby_with_features(lat, lon, features)
    hospitals = Hospital.joins(:features).where(features: {name: @features} )
  end

end
