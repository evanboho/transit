namespace :import do

  task :agencies => :environment do
    NextBus.import_remote_agencies
  end

  task :routes, :agency_tag do |t, args|
    NextBus.import_routes_for_agency args.agency_tag
  end

end
