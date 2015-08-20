class CreateAboutLists < ActiveRecord::Migration
  def change
    create_table :about_lists do |t|

      t.timestamps null: false
    end
  end
end
