class User < Sequel::Model
  plugin :validation_helpers

  include Shield::Model

  def validate
    super
    validates_presence [:username, :email]
    validates_unique :username
    validates_unique :email

    errors.add(:password, 'cannot be empty') if !crypted_password || crypted_password.empty?
  end

  def self.fetch identifier
    filter(username: identifier).first || filter(email: identifier).first
  end
end
