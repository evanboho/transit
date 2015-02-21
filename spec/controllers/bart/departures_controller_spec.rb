require 'rails_helper'

describe Bart::DeparturesController, type: :controller do

  it 'gets departures for stop' do
    VCR.use_cassette('bart_departures_for_woak') do
      get :index, stop_id: 'WOAK'
    end
    json = JSON.parse response.body
    expect(json.map { |a| a['minutes'] }).to eq ["2", "24", "38", "14", "34", "54", "7", "28", "46", "4", "24", "44"]
    expect(json.map { |a| a['direction'] }).to eq ["South", "South", "South", "North", "North", "North", "North", "North", "North", "South", "South", "South"]
    expect(json.map { |a| a['station_name'] }.uniq).to eq ["West Oakland"]
    expect(json.map { |a| a['station_name'] }.count).to eq 12
  end

end
