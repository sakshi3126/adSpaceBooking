include DisplayHelper
class Slot < ApplicationRecord
  belongs_to :user
  has_one :bid, dependent: :destroy

  validates_presence_of :title
  validates_presence_of :status
  validates_presence_of :user
  validates_uniqueness_of :start_at
  validates_uniqueness_of :end_at, on: :update, allow_nil: true

  validate :start_at_uniq?
  validate :end_at_uniq?

  enum statuses: {
      'Free Slot': 0,
      'Pre Booked Slot': 1,
      'Occupied Slot': 2,
      'Bid Approval Pending': 3
  }

  # def start_at_uniq?
  #   if !id.present?
  #     date_uniq = Slot.all.pluck(:start_at)
  #     if date_uniq.include?(start_at)
  #       errors.add(:start_at, "#{start_at} already exists.")
  #     end
  #   end
  # end

  def start_at_uniq?
    if !id.present?
      date_uniq = Slot.all.pluck(:start_at)
      date_uniq.each do |date|
        date = date.strftime('%d-%b-%Y, %H')
        if (date == start_at.strftime('%d-%b-%Y, %H'))
          errors.add(:start_at, "#{start_at.strftime('%d-%b-%Y, %H %p')} already exists.")
        elsif ((start_at.strftime('%d-%b-%Y, %H') == end_at.strftime('%d-%b-%Y, %H')))
          errors.add(:start_at, "#{start_at.strftime('%d-%b-%Y, %H %p')} can not be same as end at.")
        else
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
end
