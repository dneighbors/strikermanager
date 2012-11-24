class Team < ActiveRecord::Base
  has_one :private_league, :class_name => "PrivateLeague", :foreign_key => "league_id", :primary_key => "private_league_id"  
end
