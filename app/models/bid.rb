include DisplayHelper
class Bid < ApplicationRecord
  belongs_to :user
  belongs_to :slot
end
