class NextBus::Stop < ActiveRecord::Base
  self.table_name = 'next_bus_stops'
  belongs_to :route

  reverse_geocoded_by :lat, :long

  alias_attribute :lon, :long
  alias_attribute :stopId, :stop_id
end
