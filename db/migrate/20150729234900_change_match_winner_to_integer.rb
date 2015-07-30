class ChangeMatchWinnerToInteger < ActiveRecord::Migration
  def change
    remove_column :matches, :winner, :string
    remove_column :matches, :loser, :string
    add_column :matches, :winner, :integer
    add_column :matches, :loser, :integer
  end
end
