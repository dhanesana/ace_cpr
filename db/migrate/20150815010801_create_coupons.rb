class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
      t.string :code
      t.integer :discount
      t.references :type

      t.timestamps null: false
    end
  end
end
