class AddOrderToTypes < ActiveRecord::Migration
  def change
    add_column :types, :order, :integer, default: 9999
  end
end
