class CreateRaces < ActiveRecord::Migration[7.0]
  def change
    create_table :races do |t|
      t.string :name
      t.datetime :date
      t.float :distance
      t.float :elevationgain
      t.float :elevationloss

      t.timestamps
    end
  end
end
