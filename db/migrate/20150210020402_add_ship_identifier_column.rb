class AddShipIdentifierColumn < ActiveRecord::Migration
  def change
    add_column :locations, :mmsi, :integer
    add_column :locations, :imo, :integer
  end
end
