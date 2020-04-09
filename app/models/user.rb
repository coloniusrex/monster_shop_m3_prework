class User < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip, :email
  

  has_many :orders

  has_secure_password
end
