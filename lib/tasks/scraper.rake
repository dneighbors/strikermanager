namespace :scraper do 
  task :scrape => :environment do
    TeamScraper.new.run
  end

  task :load_teams_from_leagues => :environment do
    TeamScraper.new.load_teams_from_leagues  
  end
  
  task :update_teams => :environment do
    TeamScraper.new.update_teams
  end

  # task :wipe => :environment do
  #   Car.destroy_all
  # end
end