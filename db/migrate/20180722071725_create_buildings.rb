class CreateBuildings < ActiveRecord::Migration[5.2]
  def change
    create_table :buildings do |t|
      t.st_point :lonlat, geographic: true
      t.string :full_address

      t.timestamps
    end
    add_index :buildings, :lonlat, using: :gist
  end
end
