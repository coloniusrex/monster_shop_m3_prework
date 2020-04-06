class User < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip, :email, :password, :confirm_pass

  def self.existing_email?(email)
    User.exists?(email: email)
  end
end
