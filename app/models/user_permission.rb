class UserPermission < ApplicationRecord

  belongs_to :user, inverse_of: :user_permissions
  belongs_to :permission, inverse_of: :user_permissions

  validates_uniqueness_of :permission_id, scope: :user_id
end
