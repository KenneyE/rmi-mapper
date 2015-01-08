class CreateAttributes < ActiveRecord::Migration
  def change
    create_table :attributes do |t|
      t.string :name, null: false
      t.text :description

      t.timestamps
    end
  end
end
