class ChangeLocationFeaturesToHospitalFeatures < ActiveRecord::Migration
  def change

    remove_index :location_features, :location_id
    add_column :location_features, :hospital_id, :integer, references: :hospitals
    rename_table :location_features, :hospital_features
  end
end
