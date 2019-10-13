class TaskSerializer
  include FastJsonapi::ObjectSerializer

  attributes :description

  belongs_to :project
end
