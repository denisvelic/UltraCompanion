class ChangeColumnToRace < ActiveRecord::Migration[7.0]
  def change
    change_column :races, :gpx_file, :text, limit: 16.megabytes - 1
  end
end
