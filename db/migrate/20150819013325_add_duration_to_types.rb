class AddDurationToTypes < ActiveRecord::Migration
  def change
    add_column :types, :duration, :string, default: ''
  end
end
