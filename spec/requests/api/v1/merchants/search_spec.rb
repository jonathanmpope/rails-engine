require 'rails_helper'

describe "Merchants Search API" do
    describe 'happy path testing' do 
        it "returns a list of merchants API (find_all)" do
            merchant1 = Merchant.create!(name: "K-MART", created_at: Time.now, updated_at: Time.now)
            merchant2 = Merchant.create!(name: "Cheese Mart", created_at: Time.now, updated_at: Time.now)
            merchant3 = Merchant.create!(name: "Bob's Shoes", created_at: Time.now, updated_at: Time.now)
            merchant4 = Merchant.create!(name: "Adventure Shop", created_at: Time.now, updated_at: Time.now)

            get "/api/v1/merchants/find_all?name=mart"
            
            expect(response).to be_successful

            merchants = JSON.parse(response.body, symbolize_names: true)
             
            expect(merchants).to have_key(:data)
            expect(merchants[:data].count).to eq(2)
            expect(merchants[:data].class).to eq(Array)

            merchants[:data].each do |merchant|
                expect(merchant).to have_key(:id)
                expect(merchant[:id]).to be_a(String)

                expect(merchant).to have_key(:type)
                expect(merchant[:type]).to eq("merchant")

                expect(merchant).to have_key(:attributes)

                expect(merchant[:attributes]).to have_key(:name)
                expect(merchant[:attributes][:name]).to be_a(String)

                expect(merchant[:attributes]).to_not have_key(:created_at)
                expect(merchant[:attributes]).to_not have_key(:updated_at)
            end

            expect(merchants[:data][0][:attributes][:name]).to eq("K-MART")
            expect(merchants[:data][1][:attributes][:name]).to eq("Cheese Mart")
        end

        it "returns a merchant via API (find)" do
            merchant1 = Merchant.create!(name: "K-MART", created_at: Time.now, updated_at: Time.now)
            merchant2 = Merchant.create!(name: "Cheese Mart", created_at: Time.now, updated_at: Time.now)
            merchant3 = Merchant.create!(name: "Bob's Shoes", created_at: Time.now, updated_at: Time.now)
            merchant4 = Merchant.create!(name: "Adventure Shop", created_at: Time.now, updated_at: Time.now)

            get "/api/v1/merchants/find?name=mart"
            
            expect(response).to be_successful

            merchant = JSON.parse(response.body, symbolize_names: true)

            expect(merchant).to have_key(:data)
            expect(merchant[:data].class).to eq(Hash)
            
            expect(merchant[:data]).to have_key(:id)
            expect(merchant[:data][:id]).to be_a(String)

            expect(merchant[:data]).to have_key(:type)
            expect(merchant[:data][:type]).to eq("merchant")

            expect(merchant[:data]).to have_key(:attributes)

            expect(merchant[:data][:attributes]).to have_key(:name)
            expect(merchant[:data][:attributes][:name]).to eq("Cheese Mart")

            expect(merchant[:data][:attributes]).to_not have_key(:created_at)
            expect(merchant[:data][:attributes]).to_not have_key(:updated_at)
        end
    end
    
    describe 'sad path testing' do 
        it "returns an error when not passing info in the name search" do
            merchant1 = Merchant.create!(name: "K-MART", created_at: Time.now, updated_at: Time.now)
            merchant2 = Merchant.create!(name: "Cheese Mart", created_at: Time.now, updated_at: Time.now)
            merchant3 = Merchant.create!(name: "Bob's Shoes", created_at: Time.now, updated_at: Time.now)
            merchant4 = Merchant.create!(name: "Adventure Shop", created_at: Time.now, updated_at: Time.now)

            get "/api/v1/merchants/find_all?name="
            
            expect(response).to_not be_successful
            expect(response.status).to eq(400) 

            get "/api/v1/merchants/find_all"
            
            expect(response).to_not be_successful
            expect(response.status).to eq(400) 
         end 

         it "returns an empty array when no items match the search" do
            merchant1 = Merchant.create!(name: "K-MART", created_at: Time.now, updated_at: Time.now)
            merchant2 = Merchant.create!(name: "Cheese Mart", created_at: Time.now, updated_at: Time.now)
            merchant3 = Merchant.create!(name: "Bob's Shoes", created_at: Time.now, updated_at: Time.now)
            merchant4 = Merchant.create!(name: "Adventure Shop", created_at: Time.now, updated_at: Time.now)

            get "/api/v1/merchants/find_all?name=abcdefghij"
            
            expect(response).to be_successful
            
            merchants = JSON.parse(response.body, symbolize_names: true)

            expect(merchants).to have_key(:data)
            expect(merchants[:data].count).to eq(0) 
         end
         
        it "returns an error when not passing info in the name search" do
            merchant1 = Merchant.create!(name: "K-MART", created_at: Time.now, updated_at: Time.now)
            merchant2 = Merchant.create!(name: "Cheese Mart", created_at: Time.now, updated_at: Time.now)
            merchant3 = Merchant.create!(name: "Bob's Shoes", created_at: Time.now, updated_at: Time.now)
            merchant4 = Merchant.create!(name: "Adventure Shop", created_at: Time.now, updated_at: Time.now)

            get "/api/v1/merchants/find?name="
            
            expect(response).to_not be_successful
            expect(response.status).to eq(400) 

            get "/api/v1/merchants/find"
            
            expect(response).to_not be_successful
            expect(response.status).to eq(400) 
        end 

        it "returns an empty array when no items match the search - find API" do
            merchant1 = Merchant.create!(name: "K-MART", created_at: Time.now, updated_at: Time.now)
            merchant2 = Merchant.create!(name: "Cheese Mart", created_at: Time.now, updated_at: Time.now)
            merchant3 = Merchant.create!(name: "Bob's Shoes", created_at: Time.now, updated_at: Time.now)
            merchant4 = Merchant.create!(name: "Adventure Shop", created_at: Time.now, updated_at: Time.now)

            get "/api/v1/merchants/find?name=abcdefghij"
            
            expect(response).to be_successful
            
            merchants = JSON.parse(response.body, symbolize_names: true)

            expect(merchants).to have_key(:data)
            expect(merchants[:data].count).to eq(0) 
         end
    end 
end 