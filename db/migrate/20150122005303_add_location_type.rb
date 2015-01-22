class AddLocationType < ActiveRecord::Migration
  def change
    add_column :locations, :type, :string, null: false, default: "fixed"
  end
end
