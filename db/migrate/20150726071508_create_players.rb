class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.integer :team_id
      t.string :username
      t.integer :age
      t.integer :salary
      t.string :race
      t.integer :earnings, default: 0
      t.integer :wins, default: 0
      t.integer :losses, default: 0
      t.boolean :retired, default: false
      t.boolean :deleted, default: false

      t.timestamps null: false
    end

    add_index :players, :username
  end
end
