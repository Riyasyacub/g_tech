class CreateEnquiries < ActiveRecord::Migration[7.1]
  def change
    create_table :enquiries, id: :uuid do |t|
      t.string :name
      t.string :address
      t.string :contact_number
      t.string :referred_by
      t.float :estimated_fees, default: 0
      t.references :course, foreign_key: true, type: :uuid
      t.references :user, foreign_key: true, type: :bigint

      t.timestamps
    end

    add_reference :students, :enquiry, foreign_key: true, type: :uuid
  end
end
