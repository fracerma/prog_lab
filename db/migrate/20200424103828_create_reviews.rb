class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.integer :vote
      t.text :comment
      t.date :date

      t.timestamps
    end
  end
  
  def addRefernces
    add_column :reviews do |t|
      t.refernces :user
      t.refernces :location
    end
  end
end
