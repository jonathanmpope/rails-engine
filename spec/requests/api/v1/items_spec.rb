require 'rails_helper'

describe "Items API" do
    it "sends a list of items" do
        merch1id = create(:merchant).id
        merch2id = create(:merchant).id

        create_list(:item, 5, merchant_id: merch1id)
        create_list(:item, 3, merchant_id: merch2id)

        get '/api/v1/items'

        expect(response).to be_successful

        items = JSON.parse(response.body, symbolize_names: true)
        
        expect(items).to have_key(:data)
        expect(items[:data].count).to eq(8)
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

    it "sends an empty list of items when none are present" do
        get '/api/v1/items'

        expect(response).to be_successful

        items = JSON.parse(response.body, symbolize_names: true)
    
        expect(items).to have_key(:data)
        expect(items[:data].count).to eq(0)
    end

     it "sends a list of items" do
        merch1id = create(:merchant).id

        itemid = create(:item, merchant_id: merch1id).id

        get "/api/v1/items/#{itemid}"

        expect(response).to be_successful

        item = JSON.parse(response.body, symbolize_names: true)
        
        expect(item).to have_key(:data)
        expect(item[:data].class).to eq(Hash)

        expect(item[:data]).to have_key(:id)
        expect(item[:data][:id]).to be_a(String)

        expect(item[:data]).to have_key(:type)
        expect(item[:data][:type]).to eq("item")

        expect(item[:data]).to have_key(:attributes)

        expect(item[:data][:attributes]).to have_key(:name)
        expect(item[:data][:attributes][:name]).to be_a(String)

        expect(item[:data][:attributes]).to have_key(:description)
        expect(item[:data][:attributes][:description]).to be_a(String)
            
        expect(item[:data][:attributes]).to have_key(:unit_price)
        expect(item[:data][:attributes][:unit_price]).to be_a(Float)

        expect(item[:data][:attributes]).to have_key(:merchant_id)
        expect(item[:data][:attributes][:merchant_id]).to be_a(Integer)

        expect(item[:data][:attributes]).to_not have_key(:created_at)
        expect(item[:data][:attributes]).to_not have_key(:updated_at)
    end
end