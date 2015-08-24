class AddOrderToAboutBullets < ActiveRecord::Migration
  def change
    add_column :about_bullets, :order, :integer, default: 9999
  end
end
