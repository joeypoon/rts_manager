class FixPlayerAge < ActiveRecord::Migration
  def change
    change_column :players, :age, :integer
  end
end
