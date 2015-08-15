class CreateTypes < ActiveRecord::Migration
  def change
    create_table :types do |t|
      t.string :name
      t.string :blurb
      t.text :description
      t.integer :cost
      t.string :image_url

      t.timestamps null: false
    end
  end
end
