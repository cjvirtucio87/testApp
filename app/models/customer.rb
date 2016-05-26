class Customer < ActiveRecord::Base
  validates :name, :email, presence: true
  validates :email, format: {with: /\A[a-zA-Z\-]{4,254}@[a-zA-Z\-]{,6}mail\.\w{3}/}
end
