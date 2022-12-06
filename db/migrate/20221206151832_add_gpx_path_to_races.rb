class AddGpxPathToRaces < ActiveRecord::Migration[7.0]
  def change
    add_column :races, :gpx_path, :string
  end
end
