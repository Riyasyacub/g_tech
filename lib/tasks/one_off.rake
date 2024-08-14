require 'activerecord-import/base'

namespace :one_off do
  task create_admin: :environment do
    User.create(name: 'Admin', email: 'admin@gtec.com', password: 'password', password_confirmation: 'password', prefix: 'AD')
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
    user = User.find_by(email: "admin@gtec.com")
    Permission.all.each do |permission|
      user.permissions << permission
      user.save
    end
  end

  task remove_invalid_students: :environment do
    Student.all.each do |student|
      next if student.valid?
      student.installments.destroy_all
      student.destroy
    end
  end

  task clear_db: :environment do
    # Installment.delete_all
    # Student.delete_all
    # UserPermission.delete_all
    # User.delete_all
    # system('bundle exec rake one_off:create_admin')
    # system('bundle exec rake one_off:create_permissions')
    # system('bundle exec rake one_off:create_admin_permissions')
  end
end