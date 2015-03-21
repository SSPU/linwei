class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.references :job
      t.string     :name
      t.integer    :position
      t.boolean    :active

      t.timestamps
    end
  end
end
