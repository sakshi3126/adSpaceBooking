class SlotsController < ApplicationController
  before_action :set_slot, only: [:show, :edit, :update, :destroy, :status_wise_button]

  # GET /slots
  # GET /slots.json
  def index
    if current_user.role == "Space Provider" || current_user.role == "Organisation"
      @slots = Slot.all.order(created_at: :DESC)
    else
      current_user.role == "Space Agent"
      @slots = Slot.where(status: "Free Slot").order(created_at: :DESC)
    end
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
      if @slot.valid?
        format.html { redirect_to @slot, notice: 'Slot was successfully created.' }
        format.json { render :show, status: :created, location: @slot }
        @slot.save
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
    if current_user.role == "Space Agent"
      @free_slot = current_user.slots.where(status: 'Occupied Slot')
    else
      @free_slot = Slot.where(status: 'Occupied Slot')
    end
  end

  def free
    @free_slot = Slot.where(status: 'Free Slot')
  end

  def booked
    if current_user.role == "Space Agent"
      @free_slot = current_user.slots.where(status: 'Pre Booked Slot')
    else
      @free_slot = Slot.where(status: 'Pre Booked Slot')
    end
  end

  def status_wise_button
    respond_to do |format|
      format.html { render partial: 'status_wise_button' }
    end
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
