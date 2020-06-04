class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :locations do |t|
      t.string :name
      t.float :long
      t.float :lat
      t.string :street
      t.string :foto

      t.timestamps
    end
  end
end
