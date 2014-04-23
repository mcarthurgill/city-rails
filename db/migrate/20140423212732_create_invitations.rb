class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.integer :user_id
      t.string :invitee_name
      t.string :status
      t.string :phone_number

      t.timestamps
    end
  end
end
