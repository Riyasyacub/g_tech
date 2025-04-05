class ReportsController < ApplicationController
  before_action :set_dates

  def index
    @students = policy_scope(Student).includes(:installments, :course).order(:roll_no)
    authorize @students
    @students = @students.where("name ilike :q or roll_no ilike :q", q: "%#{params[:query]}%") if params[:query].present?
    @students = @students.where(date_of_joining: @start_date..@end_date)
    @students = @students.where(user_id: params[:user_id]) if params[:user_id].present? && current_user.admin?
    @students = @students.where(course_id: params[:course_id]) if params[:course_id].present?

    if params[:fee_percentage_from].present? && params[:fee_percentage_from].to_i > 0
      paid_amount = Installment.select("sum(amount) amount, student_id").group(:student_id).to_sql
      # @students = @students.joins("left join (#{paid_amount}) paid_amounts on paid_amounts.student_id = students.id ").where("((total_fees - paid_amounts.amount) / coalesce(NULLIF(total_fees, 0), 1)) < #{params[:fee_percentage].to_f / 100}")
      @students = @students.joins("left join (#{paid_amount}) paid_amounts on paid_amounts.student_id = students.id ").where("(paid_amounts.amount / coalesce(NULLIF(total_fees, 0), 1)) between #{params[:fee_percentage_from].to_f / 100.0} and #{(params[:fee_percentage_to] || 100).to_f / 100.0}")
    end

    if params[:crossed_days].present? && params[:crossed_days].to_i > 0
      @students = @students.where("CURRENT_DATE - date_of_joining >= #{params[:crossed_days].to_i} ")
    end

    if params[:exclude_completed_students] == '1'
      @students = @students.where("CURRENT_DATE < course_completed_at")
    end

    if params[:crossed_days_percent].present? && params[:crossed_days_percent].to_i > 0
      @students = @students.where("((course_completed_at - date_of_joining) - (course_completed_at - CURRENT_DATE))/ coalesce(NULLIF((course_completed_at - date_of_joining), 0), 1)::float >= #{params[:crossed_days_percent].to_f / 100.0}  ")
    end

    if params[:referred_by].present?
      @students = @students.where("referred_by ilike '%#{params[:referred_by]}%'")
    end

    respond_to do |format|
      format.html
      format.xlsx
    end
  end

  private

  def set_dates
    @start_date = params[:start_date]&.to_date || Date.today - 1.month
    @end_date   = params[:end_date]&.to_date || Date.today
  end
end
