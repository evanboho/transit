namespace :import do

  task :agencies => :environment do
    NextBus.import_remote_agencies
  end

  task :routes, [:agency_tag] => :environment do |t, args|
    NextBus.import_routes_for_agency tag
  end

end
