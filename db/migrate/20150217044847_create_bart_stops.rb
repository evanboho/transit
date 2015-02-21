class CreateBartStops < ActiveRecord::Migration
  def change
    create_table :bart_stops do |t|
      t.string :name
      t.string :abbr
      t.float :lat
      t.float :long
      t.string :address
      t.string :city
      t.string :county
      t.string :state
      t.string :zipcode

      t.timestamps null: false
    end
    add_index :bart_stops, [:lat, :long]
  end
end
