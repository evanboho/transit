require 'rails_helper'

describe Bart::RoutesController, type: :controller do

  it 'gets routes index' do
    VCR.use_cassette('bart_routes_index') do
      get :index
    end
    json = JSON.parse response.body
    expect(json.map { |a| a['name'] }).to eq ["Pittsburg/Bay Point - SFIA/Millbrae", "Daly City - Dublin/Pleasanton", "Daly City - Fremont", "Dublin/Pleasanton - Daly City", "Fremont - Daly City", "Fremont - Richmond", "Millbrae/Daly City - Richmond", "Richmond - Fremont", "Richmond - Daly City/Millbrae", "Millbrae/SFIA - Pittsburg/Bay Point", "Coliseum - Oakland Int'l Airport", "Oakland Int'l Airport - Coliseum"]
    expect(json.map { |a| a['abbr'] }).to eq ["PITT-SFIA", "DALY-DUBL", "DALY-FRMT", "DUBL-DALY", "FRMT-DALY", "FRMT-RICH", "MLBR-RICH", "RICH-FRMT", "RICH-MLBR", "SFIA-PITT", "COLS-OAKL", "OAKL-COLS"]
    expect(json.map { |a| a['number'] }).to eq ["1", "12", "6", "11", "5", "3", "8", "4", "7", "2", "19", "20"]
    expect(json.map { |a| a['routeID'] }).to eq ["ROUTE 1", "ROUTE 12", "ROUTE 6", "ROUTE 11", "ROUTE 5", "ROUTE 3", "ROUTE 8", "ROUTE 4", "ROUTE 7", "ROUTE 2", "ROUTE 19", "ROUTE 20"]
    expect(json.map { |a| a['color'] }).to eq ["#ffff33", "#0099cc", "#339933", "#0099cc", "#339933", "#ff9933", "#ff0000", "#ff9933", "#ff0000", "#ffff33", "#d5cfa3", "#d5cfa3"]
  end

  it 'gets show' do
    VCR.use_cassette('bart_routes_show_8') do
      get :show, id: 8
    end
    json = JSON.parse response.body
    expect(json['name']).to eq 'Millbrae/Daly City - Richmond'
    expect(json['abbr']).to eq 'MLBR-RICH'
    expect(json['routeID']).to eq 'ROUTE 8'
    expect(json['number']).to eq '8'
  end

end
