class HospitalFeature < ActiveRecord::Base
  belongs_to :hospital
  belongs_to :feature
end
