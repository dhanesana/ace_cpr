class CreateMainHeaderImages < ActiveRecord::Migration
  def change
    create_table :main_header_images do |t|
      t.string :image_url

      t.timestamps null: false
    end
  end
end
