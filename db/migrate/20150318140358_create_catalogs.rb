class CreateCatalogs < ActiveRecord::Migration
  def change
    create_table :catalogs do |t|
      t.references :person
      t.string     :name
      t.integer    :position
      t.boolean    :active

      t.timestamps
    end
  end
end
