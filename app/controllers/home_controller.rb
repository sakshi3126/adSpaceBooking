class HomeController < ApplicationController
  def index
    @slots = Slot.limit(10)
    @hobby_slots = Slot.by_branch('Free Slot').limit(8)
    @study_slots = Slot.by_branch('Pre Booked Slot').limit(8)
    @team_slots = Slot.by_branch('Occupied Slot').limit(8)
  end
end
