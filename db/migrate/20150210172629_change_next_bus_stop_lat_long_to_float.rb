class ChangeNextBusStopLatLongToFloat < ActiveRecord::Migration

  def up
    change_column :next_bus_stops, :lat, 'real USING (lat)::real'
    change_column :next_bus_stops, :long, 'real USING (long)::real'
    add_index :next_bus_stops, [:lat, :long]
  end

  def down
    change_column :next_bus_stops, :lat, :string
    change_column :next_bus_stops, :long, :string
    remove_index :next_bus_stops, [:lat, :long]
  end

end
