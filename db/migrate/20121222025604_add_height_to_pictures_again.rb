class AddHeightToPicturesAgain < ActiveRecord::Migration
  def change
    add_column :pictures, :height, :integer
  end
end
