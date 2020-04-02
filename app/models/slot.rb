class Slot < ApplicationRecord
  belongs_to :user
  has_many :bids, dependent: :destroy

  scope :by_branch, -> (status) do
    joins(:user).where(status: status)
  end

  enum statuses: {
      'Free Slot': 1,
      'Pre Booked Slot': 2,
      'Occupied Slot': 3
  }
end
