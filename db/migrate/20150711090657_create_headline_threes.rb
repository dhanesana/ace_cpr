class CreateHeadlineThrees < ActiveRecord::Migration
  def change
    create_table :headline_threes do |t|
      t.text :main
      t.text :sub
      t.text :content

      t.timestamps null: false
    end
  end
end
