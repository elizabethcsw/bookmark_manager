require 'data_mapper'
require 'dm-postgres-adapter'
require 'bcrypt'

class User
  include DataMapper::Resource

  property :id, Serial
  property :email, String, required: true, unique: true, format: :email_address
  property :password_digest, Text

  def password=(password)
  @password = password
  self.password_digest = BCrypt::Password.create(password)
end

  attr_reader :password
  attr_accessor :password_confirmation

  validates_confirmation_of :password #, :message => "Incorrect password confirmation"


  # property :password, String, required: true, length: 8..12
  # property :count, Integer

end
