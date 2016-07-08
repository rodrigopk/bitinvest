class AddStatisticsToCoin < ActiveRecord::Migration
  def change
    add_column :coins, :daily_coin_views, :int
    add_column :coins, :daily_volume, :float
    add_column :coins, :daily_operations, :float
  end
end
