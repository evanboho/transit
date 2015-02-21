class Bart::Stop < ActiveRecord::Base
  self.table_name = 'bart_stops'

  reverse_geocoded_by :lat, :long

  alias_attribute :gtfs_latitude, :lat
  alias_attribute :gtfs_longitude, :long

end
