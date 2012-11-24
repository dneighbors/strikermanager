class PrivateLeague < ActiveRecord::Base
  has_many :teams, :class_name => "Team", :foreign_key => "private_league_id", :primary_key => "league_id"
  
  def rank_average
    teams.average("ranking")    
  end
  
  def division_average
    teams.average("division")
  end
  
end
