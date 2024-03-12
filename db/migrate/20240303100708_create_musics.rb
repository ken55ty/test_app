class CreateMusics < ActiveRecord::Migration[7.1]
  def change
    create_table :musics do |t|
      t.string :spotify_music_id
      t.string :title
      t.string :artist
      t.text :cover_image

      t.timestamps
    end
  end
end
