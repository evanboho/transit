namespace :import do

  task :agencies => :environment do
    NextBus.import_remote_agencies
    NextBus::Agency.all.each do |agency|
      begin
        NextBus.import_routes_for_agency agency
      rescue => e
        puts "Error importing routes for #{agency.tag}"
      end
    end
  end

  task :routes, [:agency_tag] => :environment do |t, args|
    NextBus.import_routes_for_agency args.agency_tag
  end

end
