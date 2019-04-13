class AddFolderRefToArtworks < ActiveRecord::Migration[5.2]
  def change
    add_reference :artworks, :folder, foreign_key: true
  end
end
