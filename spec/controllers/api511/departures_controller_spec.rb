require 'rails_helper'

describe Api511::DeparturesController do

  it 'returns departures' do
    VCR.use_cassette('511_departures_index_bart_richmond') do
      get :index, stop_id: 17
    end
    json = JSON.parse response.body
    expect(json.length).to eq 12
    expect(json.map { |a| a['departure_time'] }).to match_array ["1", "14", "16", "18", "22", "29", "3", "32", "37", "44", "7", "9"]
  end
end
