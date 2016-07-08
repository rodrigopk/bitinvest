class AddStatisticsToUser < ActiveRecord::Migration
  def change
    add_column :users, :daily_volume, :float
    add_column :users, :daily_transactions, :float
    add_column :users, :daily_wallet_views, :float
  end
end
