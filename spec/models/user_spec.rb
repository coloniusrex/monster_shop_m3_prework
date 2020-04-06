require 'rails_helper'

describe User do
  describe "validations" do
    [:name, :address, :city, :state, :zip, :address, :password, :confirm_pass].each do |field|
      it { should validate_presence_of field }
    end
  end

  describe "class methods" do
    describe "existing_email?" do
      it "returns true/false if a user with submitted email already exists" do

        user_1 = User.create(name: "David", address: "123 Test St", city: "Denver", state: "CO", zip: "80204", email: "123@example.com", password: "password", confirm_pass: "password")
        params = Hash.new
        params[:email] = "123@example.com"

        expect(User.existing_email?(params[:email])).to eq(true)

      end
    end
  end
end
