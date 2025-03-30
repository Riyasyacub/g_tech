class ExamsController < ApplicationController
  before_action :set_student, only: %i[ edit update]


  def edit

  end

  def update
    if @student.update(update_params)
      redirect_to student_path(@student.id), success: "Student was successfully updated."
    else
      flash[:error] = @student.errors.full_messages
      redirect_to action: :edit
    end
  end

  private

  def set_student
    @student = policy_scope(Student).find_by(id: params[:id])
  end

  def update_params
    params.require(:student).permit(:exam_status, :action_date, :certificate_issued_by)
  end
end
