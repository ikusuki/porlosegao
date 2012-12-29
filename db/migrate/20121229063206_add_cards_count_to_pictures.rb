class AddCardsCountToPictures < ActiveRecord::Migration
  def change
    add_column :pictures, :cards_count, :integer, :default => 0
    Picture.reset_column_information
    Picture.find(:all).each do |p|
      Picture.update_counters p.id, :cards_count => p.cards.length
    end
  end
end
