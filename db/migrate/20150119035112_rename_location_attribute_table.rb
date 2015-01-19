class RenameLocationAttributeTable < ActiveRecord::Migration
  def change
    rename_table :location_attributes, :location_features
  end
end
