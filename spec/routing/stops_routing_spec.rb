require 'rails_helper'

describe StopsController do

  it 'routes to index' do
    expect(
      get: 'agencies/BART/routes/1234/stops'
    ).to route_to(controller: 'stops', action: 'index', agency_id: 'BART', route_id: '1234')
  end

  it 'routes to index with direction' do
    expect(
      get: 'agencies/BART/routes/1234/North/stops'
    ).to route_to(controller: 'stops', action: 'index', agency_id: 'BART', route_id: '1234', direction: 'North')
  end

end
