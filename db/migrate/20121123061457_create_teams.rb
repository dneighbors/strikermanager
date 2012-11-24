class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.integer :private_league_id
      t.integer :team_id
      t.integer :division
      t.integer :ranking

      t.timestamps
    end
  end
end
