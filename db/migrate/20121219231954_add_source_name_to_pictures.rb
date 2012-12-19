class AddSourceNameToPictures < ActiveRecord::Migration
  def change
    add_column :pictures, :source_name, :string
  end
end
