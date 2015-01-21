class Hospital < ActiveRecord::Base
  validates :name, presence: true

  has_many :hospital_features
  has_many :features, through: :hospital_features

  def self.find_center(locations)
    {lat: locations.average("lat"), lon: locations.average("lon")}
  end
end
