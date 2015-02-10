class AddShortTitleToNextBusRoute < ActiveRecord::Migration
  def change
    add_column :next_bus_routes, :short_title, :string
  end
end
