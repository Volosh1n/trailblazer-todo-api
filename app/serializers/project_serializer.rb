class ProjectSerializer
  include FastJsonapi::ObjectSerializer

  attributes :name

  belongs_to :user
  has_many :tasks
end
