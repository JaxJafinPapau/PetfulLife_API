class CreateProduct < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.float :avg_price
      t.float :avg_rating

      t.timestamps
    end
  end
end
