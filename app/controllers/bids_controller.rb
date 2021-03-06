class BidsController < ApplicationController
  before_action :set_bid, only: [:show, :edit, :update, :destroy, :approval, :rejection]

  def index
    if current_user.role == "Organisation"
      @bids = current_user.bids
    elsif current_user.role == "Space Agent"
      @bids = Bid.all
      @bids.each do |bid|
        valid_data = (bid.slot.status == 'Bid Approval Pending' && bid.status != "Rejected")
      end
    end
  end

  def show
  end

  def approval
    if @bid.present?
      @bid.update_attributes(status: "Approved", user_id: @bid.user.id)
      @bid.slot.update_attributes(status: "Occupied Slot") if @bid.slot.present?
      UserMailer.sent_for_approval(@bid.user, @bid).deliver_now!
    end
    redirect_to bids_path, notice: flash_message(@bid, action_name)
  end

  def rejection
    if @bid.present?
      @bid.update_attributes(status: "Rejected")
      @bid.slot.update_attributes(status: "Pre Booked Slot") if @bid.slot.present?
      UserMailer.sent_for_approval(@bid.user, @bid).deliver_now!
    end
    redirect_to bids_path, notice: flash_message(@bid, action_name)
  end

  def new
    if params[:slot_id].present?
      @slot = Slot.find(params[:slot_id])
      @bid = Bid.new(slot: @slot)
    end
  end

  def edit
  end

  def create
    @bid = Bid.new(bid_params)
    respond_to do |format|
      if @bid.save
        UserMailer.sent_for_approval(@user, @bid).deliver_now
        @bid.slot.update_attributes(status: 'Bid Approval Pending')
        format.html { redirect_to bid_path(@bid), notice: 'Slot was successfully created.' }
        format.json { render :show, status: :created, location: @bid }
        @bid.save
      else
        format.html { render :new }
        format.json { render json: @bid.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @bid.update(bid_params)
        format.html { redirect_to bid_path(@bid), notice: 'Slot was successfully updated.' }
        format.json { render :show, status: :ok, location: @bid }
      else
        format.html { render :edit }
        format.json { render json: @bid.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @bid.destroy
    respond_to do |format|
      format.html { redirect_to bids_url, notice: 'Slot was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_bid
    @bid = Bid.find(params[:id])
  end

  def bid_params
    params.require(:bid).permit(:amount, :status, :user_id, :slot_id, :bid_by)
  end

end
