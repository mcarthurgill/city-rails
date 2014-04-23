class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.integer :user_id
      t.string :phone_number
      t.string :name

      t.timestamps
    end
  end
end
