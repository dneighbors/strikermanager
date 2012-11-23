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
    puts "Logging Out"
    visit LOGOUT_URL
    puts "Going to Login Page"
    visit LOGIN_URL
    puts "Filling out Login Form"
    fill_in 'alias', :with => 'phantomruby'
    fill_in 'pass', :with => 'phantomjs'
    click_on 'Sign in'
    
    puts "Logged In.  Visting League Page"
    visit 'http://en3.strikermanager.com/inicio.php?accion=/liga_privada.php?id_liga=41188'
    puts "Pulling Data from Teams"
    all_teams.each do |url, team|
      visit "http://en3.strikermanager.com/inicio.php?accion=#{url}"
      puts "******************"
      puts "#{team} : #{url}"
      within_frame 'marco' do
        # puts page.html
        doc = Nokogiri::HTML.parse(page.html)
        puts doc.css("table th").text()
        puts doc.xpath("//table/tbody/tr/td/a[starts-with(@href, 'liga.php')]").text()
        puts doc.xpath("//td[text()='Ranking']/following-sibling::*/div").text()
      end
      puts "******************"
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


