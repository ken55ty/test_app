class CreateMusics < ActiveRecord::Migration[7.1]
  def change
    create_table :musics do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :spotify_track_id
      t.string :title
      t.string :artist
      t.text :cover_image

      t.timestamps
    end
  end
end
