class AddIncognitoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :incognito, :string, :default => 'public'
  end
end
