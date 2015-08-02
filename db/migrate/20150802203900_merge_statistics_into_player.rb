class MergeStatisticsIntoPlayer < ActiveRecord::Migration
  def change
    add_column :players, :macro, :decimal
    add_column :players, :micro, :decimal
    add_column :players, :vt, :decimal
    add_column :players, :vz, :decimal
    add_column :players, :vp, :decimal
    add_column :players, :talent, :decimal
  end
end
