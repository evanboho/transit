class CreateNextBusStops < ActiveRecord::Migration
  def change
    create_table :next_bus_stops do |t|
      t.string :tag
      t.string :title
      t.string :lat
      t.string :long
      t.string :stop_id
      t.integer :route_id

      t.timestamps null: false
    end
    add_index :next_bus_stops, :tag
    add_index :next_bus_stops, :stop_id
    add_index :next_bus_stops, :route_id
  end
end
