class AddJsonInfoToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :json_info, :text
  end
end
