class ChangeColumn < ActiveRecord::Migration
  def change
    change_column :deals, :description, :string, default: "No description yet"
  end
end
