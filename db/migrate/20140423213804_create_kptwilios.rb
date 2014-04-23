class CreateKptwilios < ActiveRecord::Migration
  def change
    create_table :kptwilios do |t|
      t.string :body
      t.string :from_number
      t.string :to_number

      t.timestamps
    end
  end
end
