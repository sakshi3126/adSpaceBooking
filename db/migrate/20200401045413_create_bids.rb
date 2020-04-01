class CreateBids < ActiveRecord::Migration[5.2]
  def change
    create_table :bids do |t|
      t.integer :amount
      t.integer :status
      t.references :user, foreign_key: true
      t.references :slot, foreign_key: true

      t.timestamps
    end
  end
end
