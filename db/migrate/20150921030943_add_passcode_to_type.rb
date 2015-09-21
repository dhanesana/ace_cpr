class AddPasscodeToType < ActiveRecord::Migration
  def change
    add_column :types, :passcode, :string
  end
end
