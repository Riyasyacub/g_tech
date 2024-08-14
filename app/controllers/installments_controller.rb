class InstallmentsController < ApplicationController
  before_action :set_installment, only: %i[ show edit update destroy invoice ]
  before_action :set_students, only: %i[ new edit show create ]
  before_action :set_dates, only: [:index]

  layout 'invoice_layout', only: %i[ invoice ]

  # GET /installments or /installments.json
  def index
    @installments = policy_scope(Installment).includes(:student).order(date: :desc)
    authorize @installments
    @installments = @installments.joins(:student).where("students.name ilike :q or students.roll_no ilike :q or invoice_number ilike :q or students.courses ilike :q", q: "%#{params[:query]}%") if params[:query].present?
    @installments = @installments.where(date: @start_date..@end_date)
    @installments = @installments.where(mode_of_payment: params[:payment_mode]) if params[:payment_mode].present?
  end

  # GET /installments/1 or /installments/1.json
  def show
    authorize @installment
  end

  # GET /installments/new
  def new
    @installment = current_user.installments.new
    authorize @installment, :create?
  end

  # GET /installments/1/edit
  def edit
    authorize @installment, :update?
  end

  # POST /installments or /installments.json
  def create
    @installment = current_user.installments.new(installment_params)
    authorize @installment
    respond_to do |format|
      if @installment.save
        format.html { redirect_to installment_url(@installment), success: "Installment was successfully created." }
        format.json { render :show, status: :created, location: @installment }
      else
        flash[:error] = @installment.errors.full_messages
        format.html { redirect_to action: :new }
        format.json { render json: @installment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /installments/1 or /installments/1.json
  def update
    authorize @installment
    respond_to do |format|
      if @installment.update(installment_params)
        format.html { redirect_to installment_url(@installment), success: "Installment was successfully updated." }
        format.json { render :show, status: :ok, location: @installment }
      else
        flash[:error] = @installment.errors.full_messages
        format.html { redirect_to action: :edit }
        format.json { render json: @installment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /installments/1 or /installments/1.json
  def destroy
    authorize @installment
    @installment.destroy!

    respond_to do |format|
      format.html { redirect_to installments_url, success: "Installment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def invoice
    authorize @installment, :index?
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_installment
    @installment = policy_scope(Installment).find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def installment_params
    params.require(:installment).permit(:student_id, :date, :amount, :mode_of_payment, :installment_type, :txn_number)
  end

  def set_students
    @students = policy_scope(Student)
  end

  def set_dates
    @start_date = params[:start_date]&.to_date || Date.today - 1.month
    @end_date   = params[:end_date]&.to_date || Date.today
  end
end
