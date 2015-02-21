require 'rails_helper'

describe Bart do

  it 'creates url with token' do
    expect(Bart.url_with_token('asdf.aspx')).to eq "http://api.bart.gov/api/asdf.aspx?key=#{SITE_CONFIG[:api_token_bart]}"
  end

  it 'creates url with params' do
    expect(Bart.url_with_token('asdf.aspx', {station: '12th'})).to eq "http://api.bart.gov/api/asdf.aspx?station=12th&key=#{SITE_CONFIG[:api_token_bart]}"
  end

  it 'deletes blank params' do
    expect(Bart.url_with_token('asdf.aspx', {station: '12th', direction: nil})).to eq "http://api.bart.gov/api/asdf.aspx?station=12th&key=#{SITE_CONFIG[:api_token_bart]}"
  end

end
