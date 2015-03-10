class Hospital < ActiveRecord::Base
  validates :name, presence: true

  has_many :hospital_features, dependent: :destroy
  has_many :features, through: :hospital_features

  def self.find_center(locations)
    {lat: locations.average("lat"), lon: locations.average("lon")}
  end

  def self.find_nearby_with_features(lat, lon, searched_features, max_dist = 45)
    lat, lon = lat.to_f, lon.to_f

    if searched_features.empty?
      hospitals = Hospital.where(lat: (lat - max_dist)..(lat + max_dist))
        .where(lon: (lon-max_dist)..(lon + max_dist))
    else
      hospitals = Hospital.joins(:features)
        .where('features.id in (?)', searched_features)
        .group("hospitals.id")
        .having('COUNT(*) = ?', searched_features.length)
        .where(lat: (lat - max_dist)..(lat + max_dist))
        .where(lon: (lon - max_dist)..(lon + max_dist))
    end
  end

end
