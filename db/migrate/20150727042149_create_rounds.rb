class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.integer :tournament_id
      t.string :winner
      t.string :loser

      t.timestamps null: false
    end

    add_index :rounds, :tournament_id
  end
end
