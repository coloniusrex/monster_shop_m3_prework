class User < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip, :email
  has_many :orders

  has_secure_password

  enum role: { visitor: 0, basic: 1, merchant: 2, admin: 3}
end
