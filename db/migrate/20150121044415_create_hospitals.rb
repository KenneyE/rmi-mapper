class CreateHospitals < ActiveRecord::Migration
  def change
    create_table :hospitals do |t|
      t.decimal :lat
      t.decimal :lon
      t.string :name
      t.text :description

      t.timestamps
    end

    add_index :hospitals, :name
  end
end
