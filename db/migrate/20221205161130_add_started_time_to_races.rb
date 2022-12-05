class AddStartedTimeToRaces < ActiveRecord::Migration[7.0]
  def change
    add_column :races, :started_at, :time, default: nil
  end
end
