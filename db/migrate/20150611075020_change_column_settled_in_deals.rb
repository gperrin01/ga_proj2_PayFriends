class ChangeColumnSettledInDeals < ActiveRecord::Migration
  def change
    change_column :deals, :settled, :string, default: 'false'
  end
end
