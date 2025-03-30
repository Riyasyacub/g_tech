class ExamsController < ApplicationController
  before_action :set_student, only: %i[ show]


  def index
    @students = policy_scope(Student).order(:roll_no)
  end

  def show
  end

  private

  def set_student
    @student = policy_scope(Student).find_by(id: params[:id])
  end
end
