require 'capybara'
require 'capybara/dsl'
require 'capybara/poltergeist'

Capybara.default_driver = :poltergeist
# Capybara.default_driver = :webkit


class TeamScraper
  LOGOUT_URL = 'http://uk.strikermanager.com/logout.php'
  LOGIN_URL = 'http://uk.strikermanager.com'  
  PRIVATE_LEAGUE_URL = 'http://uk.strikermanager.com/inicio.php?accion=/liga_privada.php?id_liga=41188'

  include Capybara::DSL

  def run
    visit LOGOUT_URL
    visit LOGIN_URL
    fill_in 'alias', :with => 'phantomruby'
    fill_in 'pass', :with => 'phantomjs'
    click_on 'Sign in'
    
    visit PRIVATE_LEAGUE_URL
    all_teams.each do |url, team|
      visit "http://uk.strikermanager.com/inicio.php?accion=#{url}"
      within_frame 'marco' do
        puts page.html
      end
      # puts "#{team} : #{url}"
      # puts "******************"
    end

  rescue => e
    Rails.logger.warn e.message
    Rails.logger.debug e.backtrace.join("\n")
  end
  
  def all_teams
    within_frame 'marco' do
      all('td.equipo').collect do |row|
        [
          row.find('a')[:href], 
          row.find('a').text
        ]
      end
    end
  end
  
end


