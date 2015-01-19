class Location < ActiveRecord::Base
  validates :name, presence: true

  has_many :user_locations
  has_many :users, through: :user_locations

  has_many :location_features
  has_many :features, through: :location_features

  def self.find_center(locations)
    {lat: locations.average("lat"), lon: locations.average("lon")}
  end
end
