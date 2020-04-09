require 'rails_helper'

RSpec.describe 'Profile' do
  describe 'As a User' do

    before :each do
      @user = User.create(name: "David", address: "123 Test St", city: "Denver", state: "CO", zip: "80204", email: "123@example.com", password: "password", role: 1)
      visit '/login'

      fill_in :email, with: @user.email
      fill_in :password, with: @user.password
      click_on 'Login'
    end

    it "I edit my password" do

      visit '/profile'
      click_link 'Change password'

      fill_in 'password', with:'new_password'
      fill_in 'confirmation', with: 'new_password'
      click_on 'Submit'

      expect(current_path).to eq('/profile')
      expect(page).to have_content("Your password has been updated.")
      click_on 'Logout'

      expect(current_path).to eq('/')
      expect(page).to have_content("You're logged out")

      visit '/login'

      fill_in 'email', with: @user.email
      fill_in 'password', with: 'new_password'
      click_on 'Login'
      expect(current_path).to eq('/profile')
    end

    it "I need to have matching passwords" do

      visit '/profile'
      click_link 'Change password'

      fill_in 'password', with:'new_password'
      fill_in 'confirmation', with: 'different_password'
      click_on 'Submit'


      expect(page).to have_content("Your password and confirm password do not match.")

    end
  end
end
