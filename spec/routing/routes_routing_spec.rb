require 'rails_helper'

describe RoutesController do

  it 'should route to index' do
    expect(
      get: 'agencies/BART/routes'
    ).to route_to(controller: 'routes', action: 'index', agency_id: 'BART')
  end

end
