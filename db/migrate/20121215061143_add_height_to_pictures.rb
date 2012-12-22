class AddHeightToPictures < ActiveRecord::Migration
  def change
    add_column :cards, :height, :integer
  end
end
