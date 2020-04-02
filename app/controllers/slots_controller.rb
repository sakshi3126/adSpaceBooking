class SlotsController < ApplicationController
  before_action :set_slot, only: [:show, :edit, :update, :destroy]

  # GET /slots
  # GET /slots.json
  def index
    @slots = Slot.limit(10)
    @hobby_slots = Slot.by_branch('Free Slot').limit(8)
    @study_slots = Slot.by_branch('Pre Booked Slot').limit(8)
    @team_slots = Slot.by_branch('Occupied Slot').limit(8)
  end

  # GET /slots/1
  # GET /slots/1.json
  def show
  end

  # GET /slots/new
  def new
    @slot = Slot.new
  end

  # GET /slots/1/edit
  def edit
  end

  # POST /slots
  # POST /slots.json
  def create
    @slot = Slot.new(slot_params)

    respond_to do |format|
      if @slot.save
        format.html { redirect_to @slot, notice: 'Slot was successfully created.' }
        format.json { render :show, status: :created, location: @slot }
      else
        format.html { render :new }
        format.json { render json: @slot.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /slots/1
  # PATCH/PUT /slots/1.json
  def update
    respond_to do |format|
      if @slot.update(slot_params)
        format.html { redirect_to @slot, notice: 'Slot was successfully updated.' }
        format.json { render :show, status: :ok, location: @slot }
      else
        format.html { render :edit }
        format.json { render json: @slot.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /slots/1
  # DELETE /slots/1.json
  def destroy
    @slot.destroy
    respond_to do |format|
      format.html { redirect_to slots_url, notice: 'Slot was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def occupied
    @free_slot = Slot.where(status: 'Occupied Slot')
  end

  def free
    @free_slot = Slot.where(status: 'Free Slot')
  end

  def booked
    @free_slot = Slot.where(status: 'Pre Booked Slot')
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_slot
      @slot = Slot.find(params[:id])
    end
    # def slots_for_branch(status)
    #   @status = Slot.where(status: status)
    #   # @slots = get_slots.paginate(page: params[:page])
    # end
    # def get_slots
    #   Slot.limit(30)
    # end

    # Only allow a list of trusted parameters through.
    def slot_params
      params.require(:slot).permit(:title, :start_at, :end_at, :status, :user_id)
    end
end
