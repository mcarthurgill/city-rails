class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :phone
      t.string :name
      t.string :password
      t.integer :city_id

      t.timestamps
    end
  end
end
