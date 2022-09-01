require 'rails_helper'

describe "Merchants Items API" do
    describe 'happy path testing' do 
        it "sends a list of merchant items" do
            merch1id = create(:merchant).id
            merch2id = create(:merchant).id
            create_list(:item, 5, merchant_id: merch1id)
            create_list(:item, 4, merchant_id: merch2id)

            get "/api/v1/merchants/#{merch1id}/items"

            expect(response).to be_successful
            
            items = JSON.parse(response.body, symbolize_names: true)
            
            expect(items).to have_key(:data)
            expect(items[:data].count).to eq(5)
            expect(items[:data].class).to eq(Array)

            items[:data].each do |item|
                expect(item).to have_key(:id)
                expect(item[:id]).to be_a(String)

                expect(item).to have_key(:type)
                expect(item[:type]).to eq("item")

                expect(item).to have_key(:attributes)

                expect(item[:attributes]).to have_key(:name)
                expect(item[:attributes][:name]).to be_a(String)

                expect(item[:attributes]).to have_key(:description)
                expect(item[:attributes][:description]).to be_a(String)
                    
                expect(item[:attributes]).to have_key(:unit_price)
                expect(item[:attributes][:unit_price]).to be_a(Float)

                expect(item[:attributes]).to have_key(:merchant_id)
                expect(item[:attributes][:merchant_id]).to be_a(Integer)

                expect(item[:attributes]).to_not have_key(:created_at)
                expect(item[:attributes]).to_not have_key(:updated_at)
            end
        end 

        it "sends a an empty list if there are no items" do
            merch1id = create(:merchant).id

            get "/api/v1/merchants/#{merch1id}/items"

            expect(response).to be_successful
            
            items = JSON.parse(response.body, symbolize_names: true)
            
            expect(items).to have_key(:data)
            expect(items[:data].count).to eq(0)
        end 
    end

    describe 'sad path testing' do 
        it "return an error if you request a merchant that doesn't exist" do
            get "/api/v1/merchants/99/items"

            body = JSON.parse(response.body, symbolize_names: true)

            expect(response).to_not be_successful
            expect(response.status).to eq(404) 
            expect(body[:error]).to eq("Merchant does not exist!") 
        end 
    end
end 
