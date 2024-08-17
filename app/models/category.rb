class Category < ApplicationRecord

  has_many :courses, inverse_of: :category

  validates :name, presence: true, uniqueness: true
  validates :code, presence: true, uniqueness: true

end
