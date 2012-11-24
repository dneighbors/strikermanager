class CreatePrivateLeagues < ActiveRecord::Migration
  def change
    create_table :private_leagues do |t|
      t.string :name
      t.integer :league_id

      t.timestamps
    end
  end
end
