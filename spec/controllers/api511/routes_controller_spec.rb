require 'rails_helper'

describe Api511::RoutesController do

  it 'returns routes for agency' do
    VCR.use_cassette('511_routes_index') do
      get :index, agency_id: 'BART', reload: true
    end
    json = JSON.parse response.body
    expect(json.length).to eq 9
    expect(json.map { |a| a['code'] }).to match_array ["747", "920", "917", "764", "1027", "908", "762", "722", "1561"]
  end

end
