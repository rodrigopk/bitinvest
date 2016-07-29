class CreateUserMetrics < ActiveRecord::Migration
  def change
    create_table :user_metrics do |t|
      t.decimal :wallet_value,	:default => 0
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
