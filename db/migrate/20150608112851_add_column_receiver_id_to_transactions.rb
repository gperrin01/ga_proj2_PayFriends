class AddColumnReceiverIdToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :receiver_id, :integer
  end
end
