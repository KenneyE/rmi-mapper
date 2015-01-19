class Feature < ActiveRecord::Base
  validates :name, presence: true

  has_many :location_features
  has_many :locations, through: :location_features
end
