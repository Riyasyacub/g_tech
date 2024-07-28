class InstallmentPolicy < ApplicationPolicy
  def index?
    @user.has_permission?('view_installment')
  end

  def show?
    @user.has_permission?('view_installment')
  end

  def create?
    @user.has_permission?('create_installment')
  end

  def update?
    @user.has_permission?('edit_installment')
  end

  def destroy?
    @user.has_permission?('delete_installment')
  end
end