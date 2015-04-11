class CreateInfomations < ActiveRecord::Migration
  def change
    create_table :infomations do |t|
      t.string  :name
      t.text    :content
      t.boolean :active
      t.integer :position

      t.timestamps
    end
  end
end
