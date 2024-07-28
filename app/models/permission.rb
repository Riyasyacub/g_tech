class Permission < ApplicationRecord

  has_many :user_permissions, dependent: :destroy, inverse_of: :permission
  has_many :users, through: :user_permissions

  validates :name, presence: true, uniqueness: true

  scope :active, -> { where(active: true) }
end
