class AddApiIdToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :api_id, :string
  end
end
