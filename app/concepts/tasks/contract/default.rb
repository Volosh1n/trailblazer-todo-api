class Tasks::Contract::Default < Reform::Form
  property :description
  property :project_id

  validates :description,
            length: {
              minimum: Constants::TASK_DESCRIPTION_MIN_LENGTH,
              maximum: Constants::TASK_DESCRIPTION_MAX_LENGTH
            },
            presence: true
end
