class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :user_id
      t.integer :card_id

      t.timestamps
    end
    add_column :cards, :votes, :integer
  end
end
