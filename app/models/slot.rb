include DisplayHelper
class Slot < ApplicationRecord
  belongs_to :user
  has_many :bids, dependent: :destroy

  scope :by_branch, -> (status) do
    joins(:user).where(status: status)
  end

  enum statuses: {
      'Free Slot': 0,
      'Pre Booked Slot': 1,
      'Occupied Slot': 2
  }
end
