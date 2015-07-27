class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.integer :cash, default: 10000
      t.integer :user_id
      t.boolean :bankrupt, default: false
      t.boolean :deleted, default: false

      t.timestamps null: false
    end

    add_index :teams, :user_id
  end
end
