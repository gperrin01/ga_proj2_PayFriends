class CreateCrossBalances < ActiveRecord::Migration
  def change
    create_table :cross_balances do |t|
      t.float :net_to_pay
      t.belongs_to :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :cross_balances, :users
  end
end
