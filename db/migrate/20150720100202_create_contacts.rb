class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name
      t.text :street
      t.text :area
      t.string :email

      t.timestamps null: false
    end
  end
end
