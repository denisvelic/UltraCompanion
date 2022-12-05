class AddStatusToRaces < ActiveRecord::Migration[7.0]
  def change
    add_column :races, :status, :string
  end
end
