require 'rails_helper'

describe 'browse agencies' do

  it 'gets list of agencies and renders on load' do
    VCR.use_cassette('511_agencies_index') do
      visit agencies_path
    end
    expect(page).to have_content 'BART'
    VCR.use_cassette('511_routes_index_bart') do
      click_on 'BART'
      expect(page).to have_content 'Richmond'
    end
  end

  it 'gets list of routes for BART and renders on load' do
    VCR.use_cassette('511_agencies_index') do
      VCR.use_cassette('511_routes_index_bart') do
        visit agency_routes_path(agency_id: 'BART')
      end
    end
    expect(page).to have_content 'Richmond'
    VCR.use_cassette('511_stops_index_bart_richmond') do
      click_on 'Richmond'
      expect(page).to have_content 'Montgomery St. (SF)'
    end
  end

  it 'gets list of stops for Richmond route on load' do
    VCR.use_cassette('511_agencies_index') do
      VCR.use_cassette('511_routes_index_bart') do
        VCR.use_cassette('511_stops_index_bart_richmond') do
          visit agency_route_stops_path(agency_id: 'BART', route_id: '762')
        end
      end
    end
    expect(page).to have_content 'Montgomery St. (SF)'
    VCR.use_cassette('511_departures_index_bart_richmond_montgomery') do
      click_on 'Montgomery St. (SF)'
      expect(page).to have_content 'Dublin Pleasanton: 12 minutes'
    end
  end

  it 'gets list of departures for Montgomery stop' do
    VCR.use_cassette('511_agencies_index') do
      VCR.use_cassette('511_routes_index_bart') do
        VCR.use_cassette('511_stops_index_bart_richmond') do
          VCR.use_cassette('511_departures_index_bart_richmond_montgomery') do
            visit agency_route_stop_departures_path(agency_id: 'BART', route_id: '762', stop_id: '15')
            expect(page).to have_content 'Dublin Pleasanton: 12 minutes'
            expect(all('.departures-list', text: 'Dublin Pleasanton: 8 minutes').length).to eq 0
          end
        end
      end
    end
    VCR.use_cassette('511_departures_index_bart_richmond_embarcadero') do
      click_on 'Embarcadero (SF)'
      expect(page).to have_content 'Dublin Pleasanton: 8 minutes'
    end
  end

end
