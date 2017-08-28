require 'data_mapper'
require 'dm-postgres-adapter'
require 'bcrypt'

class User
  include DataMapper::Resource

  property :id, Serial
  property :email, String, required: true, unique: true
  # , format: :email_address
  property :password_digest, Text

  def password=(password)
  @password = password
  self.password_digest = BCrypt::Password.create(password)
  end

  attr_reader :password
  attr_accessor :password_confirmation

  validates_confirmation_of :password #, :message => "Incorrect password confirmation"
  validates_format_of :email, as: :email_address

  # validates_presence_of :email #validate non-blank email on the server using model validations, This DataMapper validation will prevent the model from saving if the email is blank.  Interestingly, in DataMapper's case, creating a required property implies the necessity of the validation, so this code is not necessary.


  # property :password, String, required: true, length: 8..12
  # property :count, Integer

end
