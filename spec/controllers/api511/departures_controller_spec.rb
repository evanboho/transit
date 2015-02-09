require 'rails_helper'

describe Api511::DeparturesController do

  it 'returns departures' do
    VCR.use_cassette('511_departures_index') do
      get :index, stop_id: 24
    end
    json = JSON.parse response.body
    expect(json.length).to eq 3
    expect(json.map { |a| a['departure_time'] }).to match_array ["6", "15", "22"]
  end
end
