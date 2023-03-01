class AddStravaFieldsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :strava_id, :string
    add_column :users, :name, :string
    add_column :users, :access_token, :string
  end
end
