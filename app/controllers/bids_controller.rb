class BidsController < ApplicationController
  before_action :set_bid, only: [:show, :edit, :update, :destroy]

  def index

  end

  def show
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
      if @bid.valid?
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
