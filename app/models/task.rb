require 'date'

class Task < Sequel::Model
  plugin :validation_helpers

  many_to_one :user

  def validate
    super
    validates_presence [:description, :due_date, :category, :user_id]
  end

end
