class CreateStatistics < ActiveRecord::Migration
  def change
    create_table :statistics do |t|
      t.integer :player_id
      t.integer :macro
      t.integer :micro
      t.integer :vt
      t.integer :vz
      t.integer :vp
      t.integer :talent

      t.timestamps null: false
    end

    add_index :statistics, :player_id
  end
end
