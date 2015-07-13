class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
      t.string :code
      t.string :discount

      t.timestamps null: false
    end
  end
end
