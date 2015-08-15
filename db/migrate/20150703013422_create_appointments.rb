class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.datetime :class_date
      t.references :admin_user, index: true, foreign_key: true
      t.references :type, foreign_key: true

      t.timestamps null: false
    end
  end
end
