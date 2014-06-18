class AddUserIdOverrideToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :user_id_override, :integer
  end
end
