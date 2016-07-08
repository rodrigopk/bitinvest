class CreateUsersAverageStatistics < ActiveRecord::Migration
  def change
    create_table :users_average_statistics do |t|
      t.float :avg_volume
      t.float :avg_transactions
      t.float :avg_wallet_views

      t.timestamps null: false
    end
  end
end
