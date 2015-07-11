class CreateHeadlineTwos < ActiveRecord::Migration
  def change
    create_table :headline_twos do |t|
      t.text :main
      t.text :content

      t.timestamps null: false
    end
  end
end
