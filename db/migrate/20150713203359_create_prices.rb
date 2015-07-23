class CreatePrices < ActiveRecord::Migration
  def change
    create_table :prices do |t|
      t.string :cost
      t.references :type, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
