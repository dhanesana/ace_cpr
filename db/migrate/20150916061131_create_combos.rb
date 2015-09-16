class CreateCombos < ActiveRecord::Migration
  def change
    create_table :combos do |t|
      t.integer :primary_id
      t.integer :secondary_id

      t.timestamps null: false
    end
  end
end
