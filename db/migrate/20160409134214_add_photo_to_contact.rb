class AddPhotoToContact < ActiveRecord::Migration
  def up
    add_attachment :contacts, :photo
  end

  def down
    remove_attachment :contacts, :photo
  end
end
