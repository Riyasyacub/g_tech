class StudentsController < ApplicationController
  before_action :set_student, only: %i[ show edit update destroy summary details ]
  before_action :set_dates, only: [:index]

  # GET /students or /students.json
  def index
    @students = policy_scope(Student).includes(:installments).order(:roll_no)
    authorize @students
    @students = @students.where("name ilike :q or roll_no ilike :q", q: "%#{params[:query]}%") if params[:query].present?
    @students = @students.where(date_of_joining: @start_date..@end_date)
    @students = @students.where(user_id: params[:user_id]) if params[:user_id].present? && current_user.admin?
    respond_to do |format|
      format.html
      format.xlsx do
        authorize Installment.new
        @students = @students.includes(:installments).order(:roll_no)
      end
    end
  end

  # GET /students/1 or /students/1.json
  def show
  end

  # GET /students/new
  def new
    @student = current_user.students.new
    @categories = Category.all
  end

  # GET /students/1/edit
  def edit
    @categories = Category.all
  end

  # POST /students or /students.json
  def create
    @student = current_user.students.new(student_params)
    authorize @student
    respond_to do |format|
      if @student.save
        format.html { redirect_to student_url(@student), success: "Student was successfully created." }
        format.json { render :show, status: :created, location: @student }
      else
        flash[:error] = @student.errors.full_messages
        format.html { redirect_to action: :new }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1 or /students/1.json
  def update
    authorize @student
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to student_url(@student), success: "Student was successfully updated." }
        format.json { render :show, status: :ok, location: @student }
      else
        flash[:error] = @student.errors.full_messages
        format.html { redirect_to action: :edit }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1 or /students/1.json
  def destroy
    authorize @student
    @student.destroy!

    respond_to do |format|
      format.html { redirect_to students_url, success: "Student was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def summary

  end

  def details
    @installments = @student.installments.order(date: :desc)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_student
    @student = policy_scope(Student).find_by(id: params[:id])
  end

  # Only allow a list of trusted parameters through.
  def student_params
    params.require(:student)
          .permit(:name, :address, :contact_number, :total_fees, :course_id, :date_of_joining, :category, :exam_fee,
                  :opted_for_certificate, :institution, :referred_by, :course_completed_at, :institution_type)
  end

  def set_dates
    @start_date = params[:start_date]&.to_date || Date.today - 1.month
    @end_date   = params[:end_date]&.to_date || Date.today
  end

end
