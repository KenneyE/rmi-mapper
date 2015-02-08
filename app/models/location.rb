class Location < ActiveRecord::Base
  validates :name, presence: true

  has_many :user_locations, dependent: :destroy
  has_many :users, through: :user_locations

  def self.find_center(locations)
    {lat: locations.average("lat"), lon: locations.average("lon")}
  end
end
