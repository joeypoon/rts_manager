class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :round_id
      t.string :winner
      t.string :loser

      t.timestamps null: false
    end

    add_index :matches, :round_id
  end
end
