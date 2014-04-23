class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.string :venue_name
      t.string :venue_type
      t.integer :city_id

      t.timestamps
    end
  end
end
