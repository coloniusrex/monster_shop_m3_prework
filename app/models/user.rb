class User < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip, :email
  validates_presence_of :password, allow_nil: true

  has_secure_password
end
