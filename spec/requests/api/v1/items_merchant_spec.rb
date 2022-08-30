require 'rails_helper'

describe "Items Merchant API" do
    describe 'happy path testing' do 
        it "sends the merchant for an item" do
            merch1id = create(:merchant).id
            merch2id = create(:merchant).id
            item1 = create(:item, merchant_id: merch1id)
            item2 = create(:item, merchant_id: merch2id)

            get "/api/v1/items/#{item1.id}/merchant"

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
            expect(merchant[:data][:attributes][:name]).to be_a(String)

            expect(merchant[:data][:attributes]).to_not have_key(:created_at)
            expect(merchant[:data][:attributes]).to_not have_key(:updated_at)
        end 
    end 

    describe 'sad path testing' do 
        it "sends the merchant of an item " do
            get "/api/v1/items/55/merchant"

            body = JSON.parse(response.body, symbolize_names: true)

            expect(response).to_not be_successful
            expect(response.status).to eq(404) 
            expect(body[:error]).to eq("Item does not exist!") 
        end 
    end
end 