require 'rails_helper'

describe Api511::StopsController do

  it 'returns stops for agency and route' do
    VCR.use_cassette('511_stops_index_bart_richmond') do
      get :index, agency_id: 'BART', route_id: '762', reload: true
    end
    json = JSON.parse response.body
    expect(json.length).to eq 32
  end

end
