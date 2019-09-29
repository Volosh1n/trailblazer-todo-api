class Project < ApplicationRecord
  NAME_MINIMUM_LENGTH = 3
  NAME_MAXIMUM_LENGTH = 50

  belongs_to :user

  validates :name, length: { minimum: NAME_MINIMUM_LENGTH, maximum: NAME_MAXIMUM_LENGTH }, presence: true
end
