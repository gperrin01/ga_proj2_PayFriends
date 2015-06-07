class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name 
      t.float :to_pay
      t.float :to_receive

      t.timestamps null: false
    end
  end
end
