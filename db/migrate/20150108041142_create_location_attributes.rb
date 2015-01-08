class CreateLocationAttributes < ActiveRecord::Migration
  def change
    create_table :location_attributes do |t|
      t.references :location, index: true
      t.references :attribute, index: true

      t.timestamps
    end
  end
end
