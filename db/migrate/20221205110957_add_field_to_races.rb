class AddFieldToRaces < ActiveRecord::Migration[7.0]
  def change
    add_column :races, :city, :string
    add_column :races, :country, :string
    add_column :races, :time, :integer
    add_column :races, :comp_distance, :text
    add_column :races, :comp_elevation, :text
    add_column :races, :comp_time, :text
  end
end
