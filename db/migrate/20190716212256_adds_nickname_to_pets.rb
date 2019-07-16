class AddsNicknameToPets < ActiveRecord::Migration[5.2]
  def change
    add_column :pets, :nickname, :string
  end
end
