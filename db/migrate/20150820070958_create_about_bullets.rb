class CreateAboutBullets < ActiveRecord::Migration
  def change
    create_table :about_bullets do |t|
      t.text :bullet
      t.integer :about_list_id, default: AboutList.all.first.id

      t.timestamps null: false
    end
  end
end
