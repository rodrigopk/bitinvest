class AddHourlyValueToCoins < ActiveRecord::Migration
  def change
    add_column :coins, :hourly_value, :float
  end
end
