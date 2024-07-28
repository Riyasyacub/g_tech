require 'activerecord-import/base'

namespace :one_off do
  task create_admin: :environment do
    User.create(name: 'Admin', email: 'admin@g-tech.com', password: 'password', password_confirmation: 'password')
  end

  task create_permissions: :environment do
    permissions = %w[student installment].map do |grp|
      %w[view create edit delete].map do |action|
        Permission.new(name: "#{action}_#{grp}", group: grp)
      end
    end.flatten

    Permission.import(permissions, on_duplicate_key_ignore: true)
  end

  task create_admin_permissions: :environment do
    user = User.find_by(email: "admin@g-tech.com")
    Permission.all.each do |permission|
      user.permissions << permission
      user.save
    end
  end
end