class RemoveToReceiveFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :to_receive, :float
  end
end
