class AddPurchasedBookToUsers < ActiveRecord::Migration
  def change
    add_column :users, :purchased_book, :boolean, :default => false
  end
end
