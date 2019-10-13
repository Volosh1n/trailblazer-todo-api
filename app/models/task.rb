class Task < ApplicationRecord
  DESCRIPTION_MIN_LENGTH = 3
  DESCRIPTION_MAX_LENGTH = 280

  belongs_to :project

  validates :description, length: { minimum: DESCRIPTION_MIN_LENGTH, maximum: DESCRIPTION_MAX_LENGTH }, presence: true
end
