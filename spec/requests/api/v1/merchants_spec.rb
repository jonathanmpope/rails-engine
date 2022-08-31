require 'rails_helper'

describe "Merchants API" do
    describe 'happy path testing' do 
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

        it "lets you create a merchant" do
            create(:merchant)
            merchant_params = ({
                    name: 'Dracula'
                    })
            headers = {"CONTENT_TYPE" => "application/json"}

            post "/api/v1/merchants", headers: headers, params: JSON.generate(merchant: merchant_params)
            
            created_merchant = Merchant.last

            expect(response).to be_successful
            
            expect(created_merchant.name).to eq('Dracula')

            merchant = JSON.parse(response.body, symbolize_names: true)

            expect(merchant).to have_key(:data)
            expect(merchant[:data].class).to eq(Hash)
            
            expect(merchant[:data]).to have_key(:id)
            expect(merchant[:data][:id]).to be_a(String)

            expect(merchant[:data]).to have_key(:type)
            expect(merchant[:data][:type]).to eq("merchant")

            expect(merchant[:data]).to have_key(:attributes)

            expect(merchant[:data][:attributes]).to have_key(:name)
            expect(merchant[:data][:attributes][:name]).to eq('Dracula')

            expect(merchant[:data][:attributes]).to_not have_key(:created_at)
            expect(merchant[:data][:attributes]).to_not have_key(:updated_at)
        end
    end 

    describe 'sad path testing' do 
        it "tells you if you tried to retrieve a merchant that doesn't exist" do
            get "/api/v1/merchants/99"

            expect(response).to_not be_successful
            expect(response.status).to eq(404) 
        end   
    end 
end