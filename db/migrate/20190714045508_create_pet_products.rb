class CreatePetProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :pet_products do |t|
      t.references :pet, forgeign_key: true
      t.references :product, forgeign_key: true
      t.text :notes
      t.boolean :good_or_bad

      t.timestamps
    end
  end
end
