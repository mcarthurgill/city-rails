class AddDefaultToDeviceTokenEnvironment < ActiveRecord::Migration
  def change
    change_column :device_tokens, :environment, :string, :default => "production"
  end
end
