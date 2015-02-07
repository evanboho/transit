require 'rails_helper'

describe V1::DeparturesController do

  it 'parses xml' do
    f = File.open 'spec/fixtures/get_next_departures_by_stop_code.xml'
    doc = Nokogiri::XML(f)
    f.close
    departures_xml = subject.send(:parse_departures_xml, doc)
    expect(departures_xml.count).to eq doc.xpath('//DepartureTime').count
    expect(departures_xml.map { |a| a[:agency] }.uniq).to match_array ['BART', 'sf-muni']
    expect(departures_xml.first[:stop_name]).to eq 'Civic Center (SF)'
    expect(departures_xml.first[:stop_code]).to eq '11'
    expect(departures_xml.first[:route_name]).to eq 'Dublin Pleasanton'
    expect(departures_xml.first[:route_code]).to eq '920'
  end
end
