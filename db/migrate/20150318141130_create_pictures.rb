class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.references :catalog
      t.references :person
      t.references :job
      t.string     :name
      t.integer    :position
      t.boolean    :active
      t.integer    :seq
      t.integer    :max_seq

      t.timestamps
    end
  end
end
