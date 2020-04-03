include DisplayHelper
class Bid < ApplicationRecord
  belongs_to :user
  belongs_to :slot

  enum statuses: {
      'Requested': 0,
      'Approved': 1,
      'Rejected': 2
  }


  after_initialize :set_defaults, if: :new_record?

  def set_defaults
    self.status ||= :'Requested'
  end
end
