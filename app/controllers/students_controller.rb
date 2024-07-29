class StudentsController < ApplicationController
  before_action :set_student, only: %i[ show edit update destroy summary ]

  # GET /students or /students.json
  def index
    @students = Student.all.order(:roll_no)
    authorize @students
    @students = @students.where("name ilike :q or roll_no ilike :q", q: "%#{params[:query]}%") if params[:query].present?
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
    @student = Student.new
  end

  # GET /students/1/edit
  def edit
  end

  # POST /students or /students.json
  def create
    @student = Student.new(student_params)
    authorize @student
    respond_to do |format|
      if @student.save
        format.html { redirect_to student_url(@student), success: "Student was successfully created." }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new, status: :unprocessable_entity }
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
        format.html { render :edit, status: :unprocessable_entity }
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

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_student
    @student = Student.find_by(id: params[:id])
  end

  # Only allow a list of trusted parameters through.
  def student_params
    params.require(:student)
          .permit(:name, :address, :contact_number, :total_fees, :courses, :date_of_joining, :category, :exam_fee,
                  :opted_for_certificate, :institution, :referred_by, :course_completed_at)
  end

end
