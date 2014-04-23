class CreatePushNotifications < ActiveRecord::Migration
  def change
    create_table :push_notifications do |t|
      t.integer :device_token_id
      t.string :message
      t.string :push_notification_type
      t.string :status

      t.timestamps
    end
  end
end
