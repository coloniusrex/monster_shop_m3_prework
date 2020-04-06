require 'rails_helper'

describe User do
  describe "validations" do
    [:name, :address, :city, :state, :zip, :address, :password, :confirm_pass].each do |field|
      it { should validate_presence_of field }
    end
  end
end
