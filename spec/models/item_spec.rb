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
  end
end 