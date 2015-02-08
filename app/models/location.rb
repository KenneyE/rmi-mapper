class Location < ActiveRecord::Base
  validates :name, presence: true
  validates :location_type, :inclusion => { :in => ['fixed', 'ship'] }

  before_validation :set_location_type

  has_many :user_locations, dependent: :destroy
  has_many :users, through: :user_locations

  def self.find_center(locations)
    {lat: locations.average("lat"), lon: locations.average("lon")}
  end

  def set_location_type
    if self.location_type == '0'
      self.location_type = 'fixed'
    elsif self.location_type == '1'
      self.location_type = 'ship'
    end
  end
end
