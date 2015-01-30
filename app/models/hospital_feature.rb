class HospitalFeature < ActiveRecord::Base
  belongs_to :hospital
  belongs_to :feature

  validates_uniqueness_of :hospital_id, :scope => [:feature_id]
end
