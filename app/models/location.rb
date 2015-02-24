require 'open-uri'
class Location < ActiveRecord::Base
  validates :name, presence: true
  validates :location_type, :inclusion => { :in => ['fixed', 'ship'] }

  before_validation :set_location_type

  has_many :user_locations, dependent: :destroy
  has_many :users, through: :user_locations

  def self.find_center(locations)
    {lat: locations.average("lat"), lon: locations.average("lon")}
  end

  def get_marine_traffic_location!
    if self.mmsi || self.imo
      identifier = self.mmsi.nil? ? "imo:#{self.imo}" : "mmsi:#{self.mmsi}"
      url = "http://services.marinetraffic.com/api/exportvessel/" +
      "#{ENV["marine_traffic_api_key"]}/protocol:json/#{identifier}"
      res = JSON.parse(open(url).read)

      unless res.empty?
        self.lat = res[0][1]
        self.lon = res[0][2]
        if self.save!
          return true
        end
      end
    end
    return false
  end

  private
  def set_location_type
    if self.location_type == '0'
      self.location_type = 'fixed'
    elsif self.location_type == '1'
      self.location_type = 'ship'
    end
  end
end
