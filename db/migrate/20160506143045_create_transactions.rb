class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.float :units
      t.references :wallet, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :transactions, [:wallet_id, :created_at]
  end
end
