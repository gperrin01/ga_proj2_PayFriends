class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      # t.date?? :date
      t.float :amount
      t.string :description
      t.boolean :settled
      t.timestamps null: false
    end
  end
end
