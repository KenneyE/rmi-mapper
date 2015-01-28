class Feature < ActiveRecord::Base
  validates :name, presence: true

  has_many :hospital_features
  has_many :hospitals, through: :hospital_features
end
