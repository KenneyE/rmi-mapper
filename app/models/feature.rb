class Feature < ActiveRecord::Base
  validates :name, presence: true

  has_many :hospital_features, dependent: :destroy
  has_many :hospitals, through: :hospital_features
end
