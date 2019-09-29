class User < ApplicationRecord
  MIN_PASSWORD_LENGTH = 6

  has_secure_password

  has_many :projects, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: MIN_PASSWORD_LENGTH }
end
