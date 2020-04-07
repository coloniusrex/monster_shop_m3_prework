require 'rails_helper'

RSpec.describe 'Site Navigation' do
  describe 'As a Merchant' do
    it "I see the merchant links on the nav bar plus links for a registered user" do
      user = User.create(name: "David", address: "123 Test St", city: "Denver", state: "CO", zip: "80204", email: "123@example.com", password: "password", role: 2)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit '/'
      within 'nav' do
        expect(page).to have_link('Profile')
        expect(page).to have_link('Logout')
        expect(page).to have_link('Merchant Dashboard')
        expect(page).to have_no_link('Log In')
        expect(page).to have_no_link('Register')
        expect(page).to have_content("Logged in as: #{user.name}")
      end
    end
  end
end
