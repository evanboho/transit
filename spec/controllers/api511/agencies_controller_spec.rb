require 'rails_helper'

describe Api511::AgenciesController do

  it 'returns agencies' do
    VCR.use_cassette('511_agencies_index') do
      get :index, reload: true
    end
    json = JSON.parse response.body
    expect(json.length).to eq 10
    expect(json.map { |a| a['name'] }).to match_array ["AC Transit", "BART", "Caltrain", "Dumbarton Express", "Marin Transit", "SamTrans", "SF-MUNI", "Vine (Napa County)", "VTA", "WESTCAT "]
  end

end
