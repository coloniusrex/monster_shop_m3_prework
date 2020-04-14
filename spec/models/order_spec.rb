require 'rails_helper'

describe Order, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }
  end

  describe "relationships" do
    it {should have_many :item_orders}
    it {should have_many(:items).through(:item_orders)}
    it {should belong_to :user}

  end

  describe 'instance methods' do
    before :each do
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
      @merchant_user = User.create(name: "David Tran", address: "123 Test St", city: "Denver", state: "CO", zip: "80204", email: "123@example.com", password: "password", role: 2)
      @meg.add_employee(@merchant_user)

      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @pull_toy = @brian.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
      @user = User.create(name: "Colin Anderson", address: "456 Wash St", city: "Denver", state: "CO", zip: "80204", email: "123@example.com", password: "password", role: 1)

      @order_1 = @user.orders.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033)

      @item_order_1 = @order_1.item_orders.create!(item: @tire, price: @tire.price, quantity: 2)
      @item_order_2 = @order_1.item_orders.create!(item: @pull_toy, price: @pull_toy.price, quantity: 3)
    end
    it 'grandtotal' do
      expect(@order_1.grandtotal).to eq(230)
    end

    it 'find_user' do
      expect(@order_1.find_user).to eq("Colin Anderson")
    end

    it 'total_quantity' do
      expect(@order_1.total_quantity).to eq(5)
    end

    it 'merchant_total_items' do
      expect(@order_1.merchant_total_items(@brian)).to eql(3)
      expect(@order_1.merchant_total_items(@meg)).to eql(2)
    end

    it 'merchant_total_cost' do
      expect(@order_1.merchant_total_cost(@brian)).to eql(30.0)
      expect(@order_1.merchant_total_cost(@meg)).to eql(200.0)
    end

    it "#merchant_specific_items - returns only items that merchant sells in order" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_user)

      expect(@order_1.item_orders).to eq([@item_order_1, @item_order_2])
      expect(@order_1.merchant_specific_items(@merchant_user)).to eq([@item_order_1])
    end
  end
end
