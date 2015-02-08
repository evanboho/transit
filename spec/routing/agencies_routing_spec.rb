require 'rails_helper'

describe AgenciesController do

  it 'should get index' do
    expect(
      get: 'agencies'
    ).to route_to(controller: 'agencies', action: 'index')
  end

end
