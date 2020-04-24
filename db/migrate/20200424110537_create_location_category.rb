class CreateLocationCategory < ActiveRecord::Migration[5.2]
  def change
    create_table :location_categories do |t|
      t.references :location, index: true, foreign_key: true
      t.references :category, index: true, foreign_key: true
    end
  end
end
