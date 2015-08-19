class AddNotesToTypes < ActiveRecord::Migration
  def change
    add_column :types, :notes, :text, default: ''
  end
end
