class LocationFeature < ActiveRecord::Base
  belongs_to :location
  belongs_to :feature
end
