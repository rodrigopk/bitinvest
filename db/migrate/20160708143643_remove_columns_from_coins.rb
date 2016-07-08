class RemoveColumnsFromCoins < ActiveRecord::Migration
  def change
    remove_column :coins, :daily_volume, :float
    remove_column :coins, :daily_operations, :float
    remove_column :coins, :daily_coin_views, :int
  end
end
