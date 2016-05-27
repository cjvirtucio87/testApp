class Customer < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A[a-zA-Z\-]{4,254}@[a-zA-Z\-]{,6}mail\.\w{3}/
  validates :name, :email, presence: true
  validates :email, presence: true, 
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
end
