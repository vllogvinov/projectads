# frozen_string_literal: true

class DropRolesTable < ActiveRecord::Migration[6.0]
  def change
    drop_table :roles
  end
end
