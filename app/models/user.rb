include DisplayHelper
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :slots, dependent: :destroy
  has_many :bids, dependent: :destroy


  enum roles: {
      'Space Provider': 1,
      'Organisation': 2,
      'Space Agent': 3
  }
end
