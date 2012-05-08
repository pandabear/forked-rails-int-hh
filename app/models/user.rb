class User < ActiveRecord::Base
  
  has_secure_password
  
  attr_accessible :email, :password, :password_confirmation
    
  validates :email, presence: true, uniqueness: true

  def serializable_hash(options = {})
    { id: self.id, email: self.email }
  end
end
