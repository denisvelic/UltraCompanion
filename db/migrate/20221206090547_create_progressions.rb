class CreateProgressions < ActiveRecord::Migration[7.0]
  def change
    create_table :progressions do |t|

      t.timestamps
    end
  end
end
