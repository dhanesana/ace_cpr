class CreateHeadlines < ActiveRecord::Migration
  def change
    create_table :headlines do |t|
      t.text :main
      t.text :content

      t.timestamps null: false
    end
  end
end
