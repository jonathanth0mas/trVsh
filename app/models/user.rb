class User
  include Mongoid::Document
  field :name, type: String
  field :email, type: String
  field :password, type: String
  field :material, type: String
  field :address, type: String
  field :bins, type: Float
  field :password_digest, type: String
  field :date, type: Date
  attr_reader :password

  def password=(unencrypted_password)
  	unless unencrypted_password.empty?
  	  @password = unencrypted_password
  	  self.password_digest = BCrypt::Password.create(unencrypted_password)
  	end
  end

  def authenticate(unencrypted_password)
    if BCrypt::Password.new(self.password_digest) == unencrypted_password
      return self 
    else
      return false
    end  	  	
  end	  



  # another way to validate presence all in one line
  # validates_presence_of :name, :email, :password
  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates :password, presence: true, length: { in: 6..20 }, confirmation: true, allow_blank: true

end


