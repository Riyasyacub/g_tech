class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  devise :timeoutable, :timeout_in => 3.hours

  has_many :user_permissions, dependent: :destroy, inverse_of: :user
  has_many :permissions, through: :user_permissions
  has_many :students, inverse_of: :user
  has_many :installments, inverse_of: :user

  scope :non_admin, -> { where.not(email: 'admin@gtec.com') }

  def admin?
    self.email == 'admin@gtec.com'
  end

  def has_permission?(permission_names = [])
    permissions.active.where(name: permission_names).exists?
  end

  def destroy
    return
  end

  def destroy!
    return
  end

  def delete
    return
  end
end
