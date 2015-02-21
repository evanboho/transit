namespace :import do

  task 'bart:stops' => :environment do
    Bart.get_stations.each do |station_attrs|
      Bart::Stop.create!(station_attrs)
    end
  end

end
