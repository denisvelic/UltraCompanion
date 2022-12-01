class CreateWaters < ActiveRecord::Migration[7.0]
  def change
    create_table :waters do |t|
      t.string :name
      t.text :gpx_file

      t.timestamps
    end
  end
end
