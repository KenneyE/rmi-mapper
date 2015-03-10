require 'open-uri'
class Location < ActiveRecord::Base
  validates :name, presence: true
  validates :location_type, :inclusion => { :in => ['fixed', 'ship'] }
  validate :ship_id_or_lat_lonmust_be_provided

  before_validation :set_location_type, :get_marine_traffic_location!

  has_many :user_locations, dependent: :destroy
  has_many :users, through: :user_locations

  def self.find_center(locations)
    {lat: locations.average("lat"), lon: locations.average("lon")}
  end

  def get_marine_traffic_location!
    return true if self.location_type !=  "ship"
    if  self.mmsi || self.imo
      identifier = self.mmsi.nil? ? "imo:#{self.imo}" : "mmsi:#{self.mmsi}"
      url = "http://services.marinetraffic.com/api/exportvessel/" +
      "#{ENV["marine_traffic_api_key"]}/protocol:json/#{identifier}"

      begin
        res = JSON.parse(open(url).read)
      rescue JSON::ParserError
        errors.add(:base, "Unable to find ship on Marine Traffic. Possibly incorrect MMSI or IMO? If you want to create ship anyway, leave type as 'Fixed'")
        return false
      else
        unless res.empty?
          self.lat = res[0][1]
          self.lon = res[0][2]
          if self.save
            return true
          end
        end
      end
    end
    false
  end

  private
  def set_location_type
    if self.location_type == '0'
      self.location_type = 'fixed'
    elsif self.location_type == '1'
      self.location_type = 'ship'
    end
  end

  def ship_id_or_lat_lonmust_be_provided
    if location_type == 'ship'
     unless imo.present? || mmsi.present?
       errors.add(:base, "IMO or MMSI must be provided for ships")
       return false
      end
    else
      unless lat.present? && lon.present?
        errors.add(:base, "Lat and Lon must be provided for fixed locations")
        return false
       end
    end
    true
  end
end
