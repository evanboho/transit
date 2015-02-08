class NextBus::Route < ActiveRecord::Base
  self.table_name = 'next_bus_routes'
  belongs_to :agency
  has_many :stops, dependent: :destroy
  validates_uniqueness_of :tag, scope: :agency_id
  alias_attribute :stopId, :stop_id
end
