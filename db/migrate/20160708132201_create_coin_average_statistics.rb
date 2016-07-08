class CreateCoinAverageStatistics < ActiveRecord::Migration
  def change
    create_table :coin_average_statistics do |t|
      t.references :coin, index: true, foreign_key: true
      t.float :total_volume
      t.float :total_operations
      t.float :avg_coin_views

      t.timestamps null: false
    end
  end
end
