class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_permissions, dependent: :destroy, inverse_of: :user
  has_many :permissions, through: :user_permissions

  def has_permission?(permission_names = [])
    permissions.active.where(name: permission_names).exists?
  end
end
