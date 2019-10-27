require 'reform/form/validation/unique_validator'

class Users::Contract::Create < Reform::Form
  PASSWORD_MIN_LENGTH = 6

  property :email
  property :password

  validates :email, presence: true, unique: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: PASSWORD_MIN_LENGTH }
end
