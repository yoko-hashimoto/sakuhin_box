class CreateArtworks < ActiveRecord::Migration[5.2]
  def change
    create_table :artworks do |t|
      t.string :image
      t.string :caption
      t.date :created_date
      t.boolean :is_published
      t.references :creator, foreign_key: true

      t.timestamps
    end
  end
end
