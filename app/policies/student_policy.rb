class StudentPolicy < ApplicationPolicy

  def index?
    @user.has_permission?('view_student')
  end

  def show?
    @user.has_permission?('view_student')
  end

  def create?
    @user.has_permission?('create_student')
  end

  def update?
    @user.has_permission?('edit_student')
  end

  def destroy?
    @user.has_permission?('delete_student')
  end

  class Scope < ApplicationPolicy::Scope

    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      if @user.admin?
        @scope.all
      else
        @scope.where(user_id: @user.id)
      end
    end
  end
end