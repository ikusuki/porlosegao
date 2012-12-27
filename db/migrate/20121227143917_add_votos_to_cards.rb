class AddVotosToCards < ActiveRecord::Migration
  def change
    rename_column :cards, :votes, :votos
  end
end
