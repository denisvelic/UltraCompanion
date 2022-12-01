class ChangeGpxFileTypeToRaces < ActiveRecord::Migration[7.0]
  def change
    change_column :races, :gpx_file, :text, limit: 1.gigabytes - 1
  end
end
