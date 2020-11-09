class CreateAnnouncements < ActiveRecord::Migration[6.0]
  def change
    create_table :announcements do |t|
      t.string :title
      t.text :content
      t.string :announcement_type
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
