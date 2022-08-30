require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to(:merchant) }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :unit_price }
    it { should validate_presence_of :merchant_id }
  end

  describe 'model tests' do
      it "#destroy_all_invoices_with_only_one_item" do
        merchant = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now)
        customer = Customer.create!(first_name: "John", last_name: "Smith", created_at: Time.now, updated_at: Time.now)
        invoice = Invoice.create!(status: :completed, created_at: "2022-07-28 09:54:09 UTC", updated_at: Time.now, customer_id: customer.id )
        item = Item.create!(name: "Watch", description: "Always a need to tell time", unit_price: 3000, merchant_id: merchant.id, created_at: Time.now, updated_at: Time.now)
        invoice_item = InvoiceItem.create!(item_id: item.id, invoice_id: invoice.id, quantity: 1, unit_price: item.unit_price, created_at: Time.now, updated_at: Time.now)
        
        item.destroy_all_invoices_with_only_one_item
        
        expect(Invoice.all).to eq([])
      end 

      it "#self.find_by_name(name)" do
          merchant = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now)
          item1 = Item.create!(name: "Watch", description: "Always a need to tell time", unit_price: 3000, merchant_id: merchant.id, created_at: Time.now, updated_at: Time.now)   
          item2 = Item.create!(name: "Goat Cheese", description: "Pretty solid on eggs", unit_price: 5000, merchant_id: merchant.id, created_at: Time.now, updated_at: Time.now)
          item3 = Item.create!(name: "American Cheese", description: "Gross", unit_price: 2000, merchant_id: merchant.id, created_at: Time.now, updated_at: Time.now)
          item4 = Item.create!(name: "Cheesey Nachos", description: "Classic", unit_price: 4000, merchant_id: merchant.id, created_at: Time.now, updated_at: Time.now)

          item = Item.find_by_name("acho")
          name = JSON.parse(item.to_json, symbolize_names: true)[:data][:attributes][:name]

          expect(name).to eq("Cheesey Nachos")
      end 

      it "#self.find_by_min_price(price)" do
          merchant = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now)
          item1 = Item.create!(name: "Watch", description: "Always a need to tell time", unit_price: 3000, merchant_id: merchant.id, created_at: Time.now, updated_at: Time.now)   
          item2 = Item.create!(name: "Goat Cheese", description: "Pretty solid on eggs", unit_price: 5000, merchant_id: merchant.id, created_at: Time.now, updated_at: Time.now)
          item3 = Item.create!(name: "American Cheese", description: "Gross", unit_price: 2000, merchant_id: merchant.id, created_at: Time.now, updated_at: Time.now)
          item4 = Item.create!(name: "Cheesey Nachos", description: "Classic", unit_price: 4000, merchant_id: merchant.id, created_at: Time.now, updated_at: Time.now)

          item = Item.find_by_min_price(4500)
          name = JSON.parse(item.to_json, symbolize_names: true)[:data][:attributes][:name]

          expect(name).to eq("Goat Cheese")
      end 

      it "#self.find_by_max_price(price)" do
          merchant = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now)
          item1 = Item.create!(name: "Watch", description: "Always a need to tell time", unit_price: 3000, merchant_id: merchant.id, created_at: Time.now, updated_at: Time.now)   
          item2 = Item.create!(name: "Goat Cheese", description: "Pretty solid on eggs", unit_price: 5000, merchant_id: merchant.id, created_at: Time.now, updated_at: Time.now)
          item3 = Item.create!(name: "American Cheese", description: "Gross", unit_price: 2000, merchant_id: merchant.id, created_at: Time.now, updated_at: Time.now)
          item4 = Item.create!(name: "Cheesey Nachos", description: "Classic", unit_price: 4000, merchant_id: merchant.id, created_at: Time.now, updated_at: Time.now)

          item = Item.find_by_max_price(2900)
          name = JSON.parse(item.to_json, symbolize_names: true)[:data][:attributes][:name]

          expect(name).to eq("American Cheese")
      end 

      it "#self.find_by_price_range(min, max)" do
          merchant = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now)
          item1 = Item.create!(name: "Watch", description: "Always a need to tell time", unit_price: 3000, merchant_id: merchant.id, created_at: Time.now, updated_at: Time.now)   
          item2 = Item.create!(name: "Goat Cheese", description: "Pretty solid on eggs", unit_price: 5000, merchant_id: merchant.id, created_at: Time.now, updated_at: Time.now)
          item3 = Item.create!(name: "American Cheese", description: "Gross", unit_price: 2000, merchant_id: merchant.id, created_at: Time.now, updated_at: Time.now)
          item4 = Item.create!(name: "Cheesey Nachos", description: "Classic", unit_price: 4000, merchant_id: merchant.id, created_at: Time.now, updated_at: Time.now)

          item = Item.find_by_price_range(3200, 5500)
          name = JSON.parse(item.to_json, symbolize_names: true)[:data][:attributes][:name]

          expect(name).to eq("Cheesey Nachos")
      end 

      it "#self.find_all_by_name(name)" do
          merchant = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now)
          item1 = Item.create!(name: "Watch", description: "Always a need to tell time", unit_price: 3000, merchant_id: merchant.id, created_at: Time.now, updated_at: Time.now)   
          item2 = Item.create!(name: "Goat Cheese", description: "Pretty solid on eggs", unit_price: 5000, merchant_id: merchant.id, created_at: Time.now, updated_at: Time.now)
          item3 = Item.create!(name: "Landals", description: "Gross", unit_price: 2000, merchant_id: merchant.id, created_at: Time.now, updated_at: Time.now)
          item4 = Item.create!(name: "Cheesey Nachos", description: "Classic", unit_price: 4000, merchant_id: merchant.id, created_at: Time.now, updated_at: Time.now)

          items = Item.find_all_by_name("cheese")
          data = JSON.parse(items.to_json, symbolize_names: true)
         
          expect(data[:data].count).to eq(2)
          expect(data[:data][0][:attributes][:name]).to eq("Goat Cheese")
          expect(data[:data][1][:attributes][:name]).to eq("Cheesey Nachos")
      end 
  end
end 