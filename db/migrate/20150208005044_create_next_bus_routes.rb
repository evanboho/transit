class CreateNextBusRoutes < ActiveRecord::Migration
  def change
    create_table :next_bus_routes do |t|
      t.string :tag
      t.string :title
      t.string :lat
      t.string :lon
      t.integer :agency_id

      t.timestamps null: false
    end
    add_index :next_bus_routes, :tag
    add_index :next_bus_routes, :agency_id
  end
end
