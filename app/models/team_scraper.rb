require 'capybara'
require 'capybara/dsl'
require 'capybara/poltergeist'
require 'nokogiri'


Capybara.default_driver = :poltergeist
# Capybara.default_driver = :webkit


class TeamScraper
  LOGOUT_URL = 'http://en.strikermanager.com/logout.php'
  LOGIN_URL = 'http://en.strikermanager.com'  

  include Capybara::DSL

  def run
    puts "deprecated.."
  end
      
  #
  # Run this at beginning of season to load teams from leagues in database
  #
  def load_teams_from_leagues
    logout
    login
    PrivateLeague.all.each do |pl|
      puts "Pulling Data from Teams for PL #{pl.name}:#{pl.league_id}"
      visit_league_url(pl.league_id)
      sleep(5)
      all_teams.each do |url, name|
        puts "     #{name} : #{url.split('=')[1]}"
        @team = Team.find_or_create_by_team_id(url.split("=")[1])  
        @team.private_league_id = pl.league_id
        @team.save!
      end
    end
  end
  
  #
  # Run this to update team stats
  #
  def update_teams
    logout
    login    

    puts "Pulling Data from Teams"
   Team.all.each do |team|
    # Team.where("id > ?", 432).each do |team|
      puts "#{team.name} : #{team.team_id}"
      load_team_data(team.team_id)
    end
  end

  def logout
    puts "Logging Out"
    visit LOGOUT_URL
  end
  
  def login
    puts "Going to Login Page"
    visit LOGIN_URL
    puts "Filling out Login Form"
    fill_in 'alias', :with => 'phantomruby'
    fill_in 'pass', :with => 'phantomjs'
    click_on 'Sign in'
  end
  
  def visit_league_url(league_id)
    puts "Logged In.  Visting League Page"
    visit "http://en3.strikermanager.com/inicio.php?accion=/liga_privada.php?id_liga=#{league_id}"
  end

  def load_team_data(team_id)
    visit "http://en3.strikermanager.com/inicio.php?accion=equipo.php?id=#{team_id}"
    sleep(5)
    puts "******************"
    within_frame 'marco' do
      doc = Nokogiri::HTML.parse(page.html)
      puts doc.css("table th").text()
      puts doc.xpath("//table/tbody/tr/td/a[starts-with(@href, 'liga.php')]").text()[5]
      puts doc.xpath("//td[text()='Ranking']/following-sibling::*/div").text().gsub(/\,/,"")
      @team = Team.find_or_create_by_team_id(team_id)  
      @team.name = doc.css("table th").text().sub(/Press Releases/,"")
      @team.division = doc.xpath("//table/tbody/tr/td/a[starts-with(@href, 'liga.php')]").text()[5]
      @team.ranking = doc.xpath("//td[text()='Ranking']/following-sibling::*/div").text().gsub(/\,/,"")
      @team.save!
    end
    puts "******************"
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


