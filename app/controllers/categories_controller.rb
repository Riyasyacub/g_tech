class CategoriesController < ApplicationController

  before_action :set_category, only: [:show]

  def index
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: @category.courses.to_json }
    end
  end

  private

  def set_category
    @category = Category.find_by(id: params[:id])
  end
end
