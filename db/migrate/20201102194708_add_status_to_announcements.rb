class AddStatusToAnnouncements < ActiveRecord::Migration[6.0]
  def change
    add_column :announcements, :status, :integer
  end
end
