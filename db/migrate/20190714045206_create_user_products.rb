class CreateUserProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :user_products do |t|
      t.references :user, forgeign_key: true
      t.references :product, forgeign_key: true
      t.integer :rating

      t.timestamps
    end
  end
end
