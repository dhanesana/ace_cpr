class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.references :appointment, index: true, foreign_key: true
      t.string :email
      t.string :phone
      t.string :stripe_id

      t.timestamps null: false
    end
  end
end
