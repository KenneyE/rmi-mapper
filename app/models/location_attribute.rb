class LocationAttribute < ActiveRecord::Base
  belongs_to :location
  belongs_to :attribute
end
