class AddCeroAsDefaultToVotesInCards < ActiveRecord::Migration
  def change
    change_column :cards, :votos, :integer, :default => 0
  end
end
