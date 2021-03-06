include DisplayHelper
class Slot < ApplicationRecord
  belongs_to :user
  has_many :bids, dependent: :destroy

  validates_presence_of :title
  validates_presence_of :status
  validates_presence_of :user
  validates_presence_of :start_at
  validates_presence_of :end_at

  validate :start_at_uniq?
  validate :end_at_uniq?

  enum statuses: {
      'Free Slot': 0,
      'Pre Booked Slot': 1,
      'Occupied Slot': 2,
      'Bid Approval Pending': 3,
      'Cancelled': 4,
      'Over': 5
  }

  # def start_at_uniq?
  #   if !id.present?
  #     date_uniq = Slot.all.pluck(:start_at)
  #     if date_uniq.include?(start_at)
  #       errors.add(:start_at, "#{start_at} already exists.")
  #     end
  #   end
  # end

  def update_slot_status
    if self.start_at <= DateTime.now
      self.update(status: 'Over')

    end
  end

  def start_at_uniq?
    if !id.present?
      date_uniq = Slot.all.pluck(:start_at)
      date_uniq.each do |date|
        date = date.strftime('%d-%b-%Y, %H')
        if (date == start_at.strftime('%d-%b-%Y, %H'))
          errors.add(:start_at, "#{start_at.strftime('%d-%b-%Y, %H %p')} already exists.")
        elsif (end_at.strftime('%d-%b-%Y, %H') <= (start_at.strftime('%d-%b-%Y, %H')))
          errors.add(:start_at, "#{start_at.strftime('%d-%b-%Y, %H %p')} Can't be same  or greater than end at.")
        elsif start_at < Time.now || start_at.to_s(:time) < Time.now.to_s(:time)
          errors.add(:start_at, "#{start_at.strftime('%d-%b-%Y, %H %p')} Cannot be back dated.")
        end
      end
    end
  end

  def end_at_uniq?
    if !id.present?
      date_uniq = Slot.all.pluck(:end_at)
      date_uniq.each do |date|
        date = date.strftime('%d-%b-%Y, %H')
        if (date == end_at.strftime('%d-%b-%Y, %H'))
          errors.add(:end_at, "#{end_at.strftime('%d-%b-%Y, %H %p')} already exists.")
        end
      end
    end
  end

  def total_time_in_hour
    start_at = self.start_at
    end_at = self.end_at
    total_time = (end_at - start_at) / 1.hour
  end

  def total_amount
    if self.total_time_in_hour != 0
      total_amount = (self.total_time_in_hour * 1000).round(2)
    else
      total_amount = 500
    end
  end

  def bid_amount
    if self.bids.present? && self.total_time_in_hour != 0
      self.total_amount + self.bids.last.amount
    end
  end
end
