class Customer < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A[a-zA-Z\-\.]{4,254}@[a-zA-Z\-]{,6}mail\.\w{3}/
  validates :name, :email, presence: true
  validates :email, presence: true, 
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  #Returns a token. Token is a string of random chars.
  def Customer.new_token
    SecureRandom.urlsafe_base64
  end

  def Customer.digest (string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def remember
    self.remember_token = Customer.new_token
    self.update_attributes(:remember_digest, Customer.digest(remember_token))
  end
end
