require 'rails_helper'

describe 'browse agencies' do

  it 'gets list of agencies on load' do
    visit agencies_path
    byebug
  end

end
