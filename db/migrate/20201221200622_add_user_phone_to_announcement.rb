# frozen_string_literal: true

class AddUserPhoneToAnnouncement < ActiveRecord::Migration[6.0]
  def change
    add_column :announcements, :phone, :string
  end
end
