class RenameAttributeTable < ActiveRecord::Migration
  def change
    rename_table :attributes, :features
  end
end
