class CreateWallets < ActiveRecord::Migration
  def change
    create_table :wallets do |t|
      t.float :units
      t.references :user, index: true, foreign_key: true
      t.references :coin, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
