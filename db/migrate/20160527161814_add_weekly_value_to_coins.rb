class AddWeeklyValueToCoins < ActiveRecord::Migration
  def change
    add_column :coins, :weekly_value, :float
  end
end
