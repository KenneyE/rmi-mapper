class Hospital < ActiveRecord::Base
  validates :name, presence: true

  has_many :hospital_features
  has_many :features, through: :hospital_features

  def self.find_center(locations)
    {lat: locations.average("lat"), lon: locations.average("lon")}
  end

  def self.find_nearby_with_features(lat, lon, features, max_dist = 500)
    lat, lon = lat.to_f, lon.to_f
    hospitals = Hospital.joins(:features)
      .where(features: {name: features} )
      .where(lat: (lat - 10)..(lat + 10))
      .where(lon: (lon-10)..(lon + 10))
  end

end
