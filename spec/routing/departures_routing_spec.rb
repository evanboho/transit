require 'rails_helper'

describe DeparturesController do

  it 'routes to index' do
    expect(
      get: 'agencies/BART/routes/1234/stops/5678'
    ).to route_to(controller: 'departures', action: 'index', agency_id: 'BART', route_id: '1234', stop_id: '5678')
  end

  it 'routes to index with direction' do
    expect(
      get: 'agencies/BART/routes/1234/South/stops/5678'
    ).to route_to(controller: 'departures', action: 'index', agency_id: 'BART', route_id: '1234', direction: 'South', stop_id: '5678')
  end

end
