class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      # info aggiuntive
      t.string :name
      t.string :avatar

      t.timestamps
    end
  end
end
