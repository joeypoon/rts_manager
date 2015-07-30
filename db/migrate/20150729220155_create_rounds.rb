class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.integer :tournament_id
      t.integer :players, array: true, default: []
      t.integer :winners, array: true, default: []
      t.integer :round_number

      t.timestamps null: false
    end

    add_index :rounds, :tournament_id
  end
end
