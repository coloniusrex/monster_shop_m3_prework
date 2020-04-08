require 'rails_helper'

RSpec.describe 'Profile' do
  describe 'As a User' do
    it "I edit my password" do
      user = User.create(name: "David", address: "123 Test St", city: "Denver", state: "CO", zip: "80204", email: "123@example.com", password: "password", role: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit '/profile'
      click_link 'Change password'

      fill_in 'password', with:'new_password'
      fill_in 'confirm password', with: 'new_password'
      click_on 'Submit'

      expect(current_path).to eq('/profile')
      expect(page).to have_content("Your password has been updated.")
      click_on 'Logout'
      visit '/login'

      fill_in :email, with: user.email
      fill_in :password, with: 'new_password'
      click_on 'Login'
      expect(current_path).to eq('/profile')
    end
  end
end
