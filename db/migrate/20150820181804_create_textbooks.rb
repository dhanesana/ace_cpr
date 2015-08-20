class CreateTextbooks < ActiveRecord::Migration
  def change
    create_table :textbooks do |t|
      t.references :type
      t.string :name
      t.string :buy_url
      t.string :image_url

      t.timestamps null: false
    end
  end
end
