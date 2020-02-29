require 'reform/form/active_model/validations'

Reform::Form.class_eval do
  feature Reform::Form::ActiveModel::Validations
end
