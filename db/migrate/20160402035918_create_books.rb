class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.text :description
      t.integer :cost
      t.integer :type_id

      t.timestamps null: false
    end
  end
end
