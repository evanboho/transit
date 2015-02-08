class NextBus::Agency < ActiveRecord::Base
  self.table_name = 'next_bus_agencies'
  has_many :routes, dependent: :destroy
  validates_uniqueness_of :tag

  alias_attribute :shortTitle, :short_title
  alias_attribute :regionTitle, :region_title

  def as_json(args)
    %w(id tag title short_title region_title).inject({}) do |h, attr_name|
      h[attr_name] = self.send(attr_name)
      h
    end
  end

end
