class CreateHospitalFeatures < ActiveRecord::Migration
  def change
    drop_table :hospital_features
    create_table :hospital_features do |t|
      t.references :hospital, index: true
      t.references :feature, index: true

      t.timestamps
    end
  end
end
