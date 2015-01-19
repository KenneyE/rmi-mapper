class RenameAttributeColumns < ActiveRecord::Migration
  def change
    remove_column :location_features, :attribute_id

    add_reference :location_features, :feature, index: true
  end
end
