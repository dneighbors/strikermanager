namespace :scraper do 
  task :scrape => :environment do
    TeamScraper.new.run
  end
  
  # task :wipe => :environment do
  #   Car.destroy_all
  # end
end