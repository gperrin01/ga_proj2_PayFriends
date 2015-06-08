class RemoveToPayFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :to_pay, :float
  end
end
