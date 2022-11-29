class AddColumnToRaces < ActiveRecord::Migration[7.0]
  def change
    add_column :races, :gpx_file, :string
  end
end
