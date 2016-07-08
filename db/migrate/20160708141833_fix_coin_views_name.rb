class FixCoinViewsName < ActiveRecord::Migration
  def change
    rename_column :coin_average_statistics, :avg_coin_views, :total_coin_views
  end
end
