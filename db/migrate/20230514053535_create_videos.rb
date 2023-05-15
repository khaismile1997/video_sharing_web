class CreateVideos < ActiveRecord::Migration[6.0]
  def change
    create_table :videos do |t|
      t.string :youtube_video_id, null: false
      t.string :title, null: false
      t.text :description
      t.integer :sharer_id, null: false

      t.timestamps
    end

    add_index :videos, :sharer_id
  end
end
