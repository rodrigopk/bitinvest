class AddDailyValueToCoins < ActiveRecord::Migration
  def change
    add_column :coins, :daily_value, :float
  end
end
