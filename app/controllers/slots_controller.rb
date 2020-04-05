class SlotsController < ApplicationController
  before_action :set_slot, only: [:show, :edit, :update, :destroy, :confirm_booking, :approval, :rejection]

  # GET /slots
  # GET /slots.json
  def index
    @slots = Slot.order(created_at: :DESC).each do |slot|
      slot.update_slot_status
    end
    if current_user.role == "Space Agent"
      @slots = Slot.where(status: ["Free Slot", 'Bid Approval Pending', 'Pre Booked Slot'])
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
      if @slot.save
        @slot.update_slot_status
        UserMailer.notification_email(@user, @slot).deliver_now!
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
        @slot.update_slot_status
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

  def confirm_booking
    if @slot.present? && @slot.status == "Free Slot" && current_user.role = "Space Agent"
      @slot.update_attributes(status: "Pre Booked Slot", user_id: current_user.id)
      UserMailer.notification_email(@user, @slot).deliver_now!
    else
      @slot.update_attributes(status: "Occupied Slot", user_id: current_user.id)
      UserMailer.notification_email(@user, @slot).deliver_now!
    end
    redirect_to slots_path, notice: flash_message(@slot, action_name)
  end


  def approval
    if @slot.present?
      @slot.update_attributes(status: "Occupied Slot", user_id: @slot.bid.user.id)
      @slot.bid.update_attributes(status: "Approved") if @slot.bid.present?
      UserMailer.sent_for_approval(@slot.bid.user, @slot.bid).deliver_now!
    end
    redirect_to slots_path, notice: flash_message(@slot, action_name)
  end

  def rejection
    if @slot.present?
      @slot.update_attributes(status: "Cancelled", user_id: current_user.id)
      @slot.bid.update_attributes(status: "Rejected") if @slot.bid.present?
      UserMailer.sent_for_approval(@slot.bid.user, @slot.bid).deliver_now!
    end
    redirect_to slots_path, notice: flash_message(@slot, action_name)
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


  private

  # Use callbacks to share common setup or constraints between actions.
  def set_slot
    @slot = Slot.find(params[:id])
  end

  def slot_params
    params.require(:slot).permit(:title, :start_at, :end_at, :status, :user_id,)
  end
end
