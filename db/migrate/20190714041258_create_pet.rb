class CreatePet < ActiveRecord::Migration[5.2]
  def change
    create_table :pets do |t|
      t.string :name
      t.string :archetype
      t.string :breed
      t.references :user, forgeign_key: true

      t.timestamps
    end
  end
end
