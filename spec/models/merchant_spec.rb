require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many(:items) }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
  end

  describe 'model tests' do
    it "#self.find_by_name(name)" do
      merchant1 = Merchant.create!(name: "K-MART", created_at: Time.now, updated_at: Time.now)
      merchant2 = Merchant.create!(name: "Cheese Mart", created_at: Time.now, updated_at: Time.now)
      merchant3 = Merchant.create!(name: "Bob's Shoes", created_at: Time.now, updated_at: Time.now)
      merchant4 = Merchant.create!(name: "Adventure Shop", created_at: Time.now, updated_at: Time.now)

      merchants = Merchant.find_by_name("mart")
      data = JSON.parse(merchants.to_json, symbolize_names: true)

      expect(data[:data].count).to eq(2)
      expect(data[:data][0][:attributes][:name]).to eq("K-MART")
      expect(data[:data][1][:attributes][:name]).to eq("Cheese Mart")
    end 
  end
end 