class RenameTransactions < ActiveRecord::Migration
  def change
      rename_table :transactions, :deals
  end
end
