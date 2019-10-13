class User < ApplicationRecord
  PASSWORD_MIN_LENGTH = 6

  has_secure_password

  has_many :projects, dependent: :destroy
  has_many :tasks, through: :projects

  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: PASSWORD_MIN_LENGTH }
end
