class CreateTableComments < ActiveRecord::Migration
  def up
    create_table :comments do |t|
      t.string :comment
      t.integer :user_id
      t.integer :card_id

      t.timestamps
    end
  end

  def down
  end
end
