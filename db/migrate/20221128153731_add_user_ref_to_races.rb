class AddUserRefToRaces < ActiveRecord::Migration[7.0]
  def change
    add_reference :races, :user, null: false, foreign_key: true
  end
end
