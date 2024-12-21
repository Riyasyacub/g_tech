class EnquiriesController < ApplicationController

  before_action :set_enquiry, only: [:show, :edit, :update, :destroy]
  def index
    @enquiries = policy_scope(Enquiry.active)
    authorize @enquiries
    @enquiries = @enquiries.where("name ilike :q", q: "%#{params[:query]}%") if params[:query].present?
    @enquiries = @enquiries.where(user_id: params[:user_id]) if params[:user_id].present? && current_user.admin?
  end

  def new
    @enquiry    = current_user.enquiries.new
    @categories = Category.all
  end

  def edit
    @categories = Category.all
  end

  def show
  end

  def create
    @enquiry = current_user.enquiries.new(enquiry_params)
    authorize @enquiry
    respond_to do |format|
      if @enquiry.save
        format.html { redirect_to enquiry_url(@enquiry), success: "Enquiry was successfully created." }
        format.json { render :show, status: :created, location: @enquiry }
      else
        flash[:error] = @enquiry.errors.full_messages
        format.html { redirect_to action: :new }
        format.json { render json: @enquiry.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @enquiry
    respond_to do |format|
      if @enquiry.update(enquiry_params)
        format.html { redirect_to enquiry_url(@enquiry), success: "Enquiry was successfully updated." }
        format.json { render :show, status: :ok, location: @enquiry }
      else
        flash[:error] = @enquiry.errors.full_messages
        format.html { redirect_to action: :edit }
        format.json { render json: @enquiry.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @enquiry
    @enquiry.destroy!

    respond_to do |format|
      flash[:success] = "Enquiry was successfully destroyed."
      format.html { redirect_to enquiries_url }
      format.json { head :no_content }
    end
  end

  private

  def enquiry_params
    params.require(:enquiry)
          .permit(:name, :address, :contact_number, :estimated_fees, :course_id, :referred_by)
  end

  def set_enquiry
    @enquiry = policy_scope(Enquiry.active).find_by(id: params[:id])
  end
end
