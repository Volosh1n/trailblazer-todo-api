class Project < ApplicationRecord
  NAME_MIN_LENGTH = 3
  NAME_MAX_LENGTH = 50

  belongs_to :user
  has_many :tasks, dependent: :destroy

  validates :name, length: { minimum: NAME_MIN_LENGTH, maximum: NAME_MAX_LENGTH }, presence: true
end
