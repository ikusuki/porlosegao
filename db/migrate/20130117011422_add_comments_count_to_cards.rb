class AddCommentsCountToCards < ActiveRecord::Migration
  def change
    add_column :cards, :comments_count, :integer, :default => 0
  end
end
