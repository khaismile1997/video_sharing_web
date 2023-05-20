class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.integer :video_id, null: false

      t.timestamps
    end
  end
end
