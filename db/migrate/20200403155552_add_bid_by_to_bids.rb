class AddBidByToBids < ActiveRecord::Migration[5.2]
  def change
    add_column :bids, :bid_by, :integer
  end
end
