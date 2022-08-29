require 'rails_helper'

describe "Merchants API" do
    it "sends a list of merchants" do
        create_list(:merchant, 3)

        get '/api/v1/merchants'

        expect(response).to be_successful

        merchants = JSON.parse(response.body, symbolize_names: true)
        
        expect(merchants).to have_key(:data)
        expect(merchants[:data].count).to eq(3)
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
    end

    it "sends an empty list of merchants when none are present" do
        get '/api/v1/merchants'

        expect(response).to be_successful

        merchants = JSON.parse(response.body, symbolize_names: true)
        
        expect(merchants).to have_key(:data)
        expect(merchants[:data].count).to eq(0)
    end

    it "sends a single merchants data" do
        merchid = create(:merchant).id

        get "/api/v1/merchants/#{merchid}"

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