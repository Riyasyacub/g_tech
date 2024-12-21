class Enquiry < ApplicationRecord
  belongs_to :course, optional: true, inverse_of: :enquiries
  belongs_to :user, inverse_of: :enquiries

  has_one :student, inverse_of: :enquiry

  scope :active, -> { where("id not in (select students.enquiry_id as id from students where enquiry_id is not null)") }

end
