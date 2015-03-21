class AddAttachmentAssetToPictures < ActiveRecord::Migration
  def self.up
    change_table :pictures do |t|
      t.attachment :asset
    end
  end

  def self.down
    remove_attachment :pictures, :asset
  end
end
