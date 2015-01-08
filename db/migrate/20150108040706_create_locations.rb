class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.decimal :lat, {:precision=>10, :scale=>6}
      t.decimal :lon, {:precision=>10, :scale=>6}

      t.string :name, null: false
      t.timestamps
    end
  end
end
