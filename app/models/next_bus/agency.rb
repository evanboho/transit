class NextBus::Agency < ActiveRecord::Base
  self.table_name = 'next_bus_agencies'
  has_many :routes, dependent: :destroy
  validates_uniqueness_of :tag

  alias_attribute :shortTitle, :short_title
  alias_attribute :regionTitle, :region_title
end
