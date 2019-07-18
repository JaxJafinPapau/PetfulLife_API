class RemoveAvgRatingFromProduct < ActiveRecord::Migration[5.2]
  def change
    remove_column :products, :avg_rating
  end
end
