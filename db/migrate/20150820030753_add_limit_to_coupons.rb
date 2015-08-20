class AddLimitToCoupons < ActiveRecord::Migration
  def change
    add_column :coupons, :limit, :integer, default: 10000
  end
end
