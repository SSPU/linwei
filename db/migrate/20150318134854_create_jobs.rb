class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string  :name
      t.integer :position
      t.boolean :active
      t.boolean :index

      t.timestamps
    end
  end
end
