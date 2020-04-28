class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.integer :vote
      t.text :comment
      t.date :date
      t.references :users
      t.references :locations
      
      t.timestamps
    end
  end
  
end
