class CreateAdvertisments < ActiveRecord::Migration[6.0]
  def change
    create_table :advertisments do |t|
      t.integer :ad_id
      t.string :ad_name
      t.string :type

      t.timestamps
    end
  end
end
