class CreateNextBusAgencies < ActiveRecord::Migration
  def change
    create_table :next_bus_agencies do |t|
      t.string :tag
      t.string :title
      t.string :short_title
      t.string :region_title

      t.timestamps null: false
    end
    add_index :next_bus_agencies, :tag
  end
end
