class User < Sequel::Model
  plugin :validation_helpers

  include Shield::Model

  one_to_many :tasks

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

  def self.as_hash
    { users: User.map(&:as_hash) }
  end

  def as_hash extended: false
    {
      user: {
        id: id,
        username: username,
        email: email,
        phone_number: phone_number,
        tasks: extended ? tasks.map(&:values) : tasks.count
      }
    }
  end
end
