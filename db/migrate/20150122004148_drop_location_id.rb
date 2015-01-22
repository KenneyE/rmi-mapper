class DropLocationId < ActiveRecord::Migration
  def change
    remove_column :hospital_features, :location_id
  end
end
