class CreateAboutFonts < ActiveRecord::Migration
  def change
    create_table :about_fonts do |t|
      t.float :size, default: 1.00

      t.timestamps null: false
    end
  end
end
