class CreateRefunds < ActiveRecord::Migration
  def change
    create_table :refunds do |t|
      t.text :policy, default: ''

      t.timestamps null: false
    end
  end
end
