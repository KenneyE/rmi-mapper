class Location < ActiveRecord::Base
  validates :name, presence: true

  has_many :user_locations
  has_many :users, through: :user_locations
end
