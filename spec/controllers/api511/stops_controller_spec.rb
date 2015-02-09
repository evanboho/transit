require 'rails_helper'

describe Api511::StopsController do

  it 'returns stops for agency and route' do
    VCR.use_cassette('511_stops_index') do
      get :index, agency_id: 'BART', route_id: '920', reload: true
    end
    json = JSON.parse response.body
    expect(json.length).to eq 18
  end

end
