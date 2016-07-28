class CreateCoinMetrics < ActiveRecord::Migration
  def change
    create_table :coin_metrics do |t|
      t.decimal :value, 	:default => 0
      t.decimal :variation, :default => 0
      t.references :coin, 	index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
