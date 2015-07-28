class CreateTournaments < ActiveRecord::Migration
  def change
    create_table :tournaments do |t|
      t.string :name
      t.integer :prize_pool
      t.string :winner
      t.integer :teams, array: true, default: []

      t.timestamps null: false
    end

    add_index :tournaments, :name
  end
end
