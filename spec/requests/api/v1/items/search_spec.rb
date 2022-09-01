require 'rails_helper'

describe "Items Search API" do
    describe 'happy path testing' do 
        it "can find a single item which matches a search term - name" do
            merchant = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now)
            item1 = Item.create!(name: "Watch", description: "Always a need to tell time", unit_price: 3000, merchant_id: merchant.id, created_at: Time.now, updated_at: Time.now)   
            item2 = Item.create!(name: "Goat Cheese", description: "Pretty solid on eggs", unit_price: 5000, merchant_id: merchant.id, created_at: Time.now, updated_at: Time.now)
            item3 = Item.create!(name: "American Cheese", description: "Gross", unit_price: 2000, merchant_id: merchant.id, created_at: Time.now, updated_at: Time.now)
            item4 = Item.create!(name: "Cheesey Nachos", description: "Classic", unit_price: 4000, merchant_id: merchant.id, created_at: Time.now, updated_at: Time.now)

            get "/api/v1/items/find?name=cheese"

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
            expect(item[:data][:attributes][:name]).to eq(item3.name)

            expect(item[:data][:attributes]).to have_key(:description)
            expect(item[:data][:attributes][:description]).to eq(item3.description)
                
            expect(item[:data][:attributes]).to have_key(:unit_price)
            expect(item[:data][:attributes][:unit_price]).to eq(item3.unit_price)

            expect(item[:data][:attributes]).to have_key(:merchant_id)
            expect(item[:data][:attributes][:merchant_id]).to be_a(Integer)

            expect(item[:data][:attributes]).to_not have_key(:created_at)
            expect(item[:data][:attributes]).to_not have_key(:updated_at)
        end

        it "can find a single item based on min price" do
            merchant = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now)
            item1 = Item.create!(name: "Goat Cheese", description: "Pretty solid on eggs", unit_price: 500, merchant_id: merchant.id, created_at: Time.now, updated_at: Time.now)
            item2 = Item.create!(name: "Computer", description: "Helpful for coding", unit_price: 80000, merchant_id: merchant.id, created_at: Time.now, updated_at: Time.now)   
            item3 = Item.create!(name: "American Cheese", description: "Gross", unit_price: 200, merchant_id: merchant.id, created_at: Time.now, updated_at: Time.now)
            item4 = Item.create!(name: "Cheesey Nachos", description: "Classic", unit_price: 400, merchant_id: merchant.id, created_at: Time.now, updated_at: Time.now)

            get "/api/v1/items/find?min_price=499"

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
            expect(item[:data][:attributes][:name]).to eq(item2.name)

            expect(item[:data][:attributes]).to have_key(:description)
            expect(item[:data][:attributes][:description]).to eq(item2.description)
                
            expect(item[:data][:attributes]).to have_key(:unit_price)
            expect(item[:data][:attributes][:unit_price]).to eq(item2.unit_price)

            expect(item[:data][:attributes]).to have_key(:merchant_id)
            expect(item[:data][:attributes][:merchant_id]).to be_a(Integer)

            expect(item[:data][:attributes]).to_not have_key(:created_at)
            expect(item[:data][:attributes]).to_not have_key(:updated_at)
        end

        it "can find a single item based on max price" do
            merchant = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now)
            item1 = Item.create!(name: "Goat Cheese", description: "Pretty solid on eggs", unit_price: 500, merchant_id: merchant.id, created_at: Time.now, updated_at: Time.now)
            item2 = Item.create!(name: "Computer", description: "Helpful for coding", unit_price: 8000, merchant_id: merchant.id, created_at: Time.now, updated_at: Time.now)   
            item3 = Item.create!(name: "American Cheese", description: "Gross", unit_price: 200, merchant_id: merchant.id, created_at: Time.now, updated_at: Time.now)
            item4 = Item.create!(name: "Cheesey Nachos", description: "Classic", unit_price: 400, merchant_id: merchant.id, created_at: Time.now, updated_at: Time.now)

            get "/api/v1/items/find?max_price=499"

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
            expect(item[:data][:attributes][:name]).to eq(item3.name)

            expect(item[:data][:attributes]).to have_key(:description)
            expect(item[:data][:attributes][:description]).to eq(item3.description)
                
            expect(item[:data][:attributes]).to have_key(:unit_price)
            expect(item[:data][:attributes][:unit_price]).to eq(item3.unit_price)

            expect(item[:data][:attributes]).to have_key(:merchant_id)
            expect(item[:data][:attributes][:merchant_id]).to be_a(Integer)

            expect(item[:data][:attributes]).to_not have_key(:created_at)
            expect(item[:data][:attributes]).to_not have_key(:updated_at)
        end

        it "can find a single item based on min and max price" do
            merchant = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now)
            item1 = Item.create!(name: "Goat Cheese", description: "Pretty solid on eggs", unit_price: 5000, merchant_id: merchant.id, created_at: Time.now, updated_at: Time.now)
            item2 = Item.create!(name: "Computer", description: "Helpful for coding", unit_price: 80000, merchant_id: merchant.id, created_at: Time.now, updated_at: Time.now)   
            item3 = Item.create!(name: "American Cheese", description: "Gross", unit_price: 200, merchant_id: merchant.id, created_at: Time.now, updated_at: Time.now)
            item4 = Item.create!(name: "Cheesey Nachos", description: "Classic", unit_price: 400, merchant_id: merchant.id, created_at: Time.now, updated_at: Time.now)

            get "/api/v1/items/find?max_price=15000&min_price=4500"

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
            expect(item[:data][:attributes][:name]).to eq(item1.name)

            expect(item[:data][:attributes]).to have_key(:description)
            expect(item[:data][:attributes][:description]).to eq(item1.description)
                
            expect(item[:data][:attributes]).to have_key(:unit_price)
            expect(item[:data][:attributes][:unit_price]).to eq(item1.unit_price)

            expect(item[:data][:attributes]).to have_key(:merchant_id)
            expect(item[:data][:attributes][:merchant_id]).to be_a(Integer)

            expect(item[:data][:attributes]).to_not have_key(:created_at)
            expect(item[:data][:attributes]).to_not have_key(:updated_at)
        end

         it "can find all items which matches a search term - name" do
            merchant = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now)
            item1 = Item.create!(name: "Watch", description: "Always a need to tell time", unit_price: 3000, merchant_id: merchant.id, created_at: Time.now, updated_at: Time.now)   
            item2 = Item.create!(name: "Goat Cheese", description: "Pretty solid on eggs", unit_price: 5000, merchant_id: merchant.id, created_at: Time.now, updated_at: Time.now)
            item3 = Item.create!(name: "American Cheese", description: "Gross", unit_price: 2000, merchant_id: merchant.id, created_at: Time.now, updated_at: Time.now)
            item4 = Item.create!(name: "Cheesey Nachos", description: "Classic", unit_price: 4000, merchant_id: merchant.id, created_at: Time.now, updated_at: Time.now)

            get "/api/v1/items/find_all?name=cheese"

            expect(response).to be_successful

            items = JSON.parse(response.body, symbolize_names: true)
            
            expect(items).to have_key(:data)
            expect(items[:data].count).to eq(3)
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

            expect(items[:data][0][:attributes][:name]).to eq("Goat Cheese")
            expect(items[:data][1][:attributes][:name]).to eq("American Cheese")
        end 

        it "can find all items with a minimum price" do
            merchant = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now)
            item1 = Item.create!(name: "Watch", description: "Always a need to tell time", unit_price: 3000, merchant_id: merchant.id, created_at: Time.now, updated_at: Time.now)   
            item2 = Item.create!(name: "Goat Cheese", description: "Pretty solid on eggs", unit_price: 5000, merchant_id: merchant.id, created_at: Time.now, updated_at: Time.now)
            item3 = Item.create!(name: "American Cheese", description: "Gross", unit_price: 2000, merchant_id: merchant.id, created_at: Time.now, updated_at: Time.now)
            item4 = Item.create!(name: "Cheesey Nachos", description: "Classic", unit_price: 4000, merchant_id: merchant.id, created_at: Time.now, updated_at: Time.now)

            get "/api/v1/items/find_all?min_price=3100"

            expect(response).to be_successful

            items = JSON.parse(response.body, symbolize_names: true)
            
            expect(items).to have_key(:data)
            expect(items[:data].count).to eq(2)
            expect(items[:data].class).to eq(Array)
             
            expect(items[:data][0][:attributes][:name]).to eq("Goat Cheese")
            expect(items[:data][1][:attributes][:name]).to eq("Cheesey Nachos")
        end 

        it "can find all items with a max price" do
            merchant = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now)
            item1 = Item.create!(name: "Watch", description: "Always a need to tell time", unit_price: 3000, merchant_id: merchant.id, created_at: Time.now, updated_at: Time.now)   
            item2 = Item.create!(name: "Goat Cheese", description: "Pretty solid on eggs", unit_price: 5000, merchant_id: merchant.id, created_at: Time.now, updated_at: Time.now)
            item3 = Item.create!(name: "American Cheese", description: "Gross", unit_price: 2000, merchant_id: merchant.id, created_at: Time.now, updated_at: Time.now)
            item4 = Item.create!(name: "Cheesey Nachos", description: "Classic", unit_price: 4000, merchant_id: merchant.id, created_at: Time.now, updated_at: Time.now)

            get "/api/v1/items/find_all?max_price=3100"

            expect(response).to be_successful

            items = JSON.parse(response.body, symbolize_names: true)
            
            expect(items).to have_key(:data)
            expect(items[:data].count).to eq(2)
            expect(items[:data].class).to eq(Array)
             
            expect(items[:data][0][:attributes][:name]).to eq("Watch")
            expect(items[:data][1][:attributes][:name]).to eq("American Cheese")
        end 

        it "can find all items within a range" do
            merchant = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now)
            item1 = Item.create!(name: "Watch", description: "Always a need to tell time", unit_price: 3000, merchant_id: merchant.id, created_at: Time.now, updated_at: Time.now)   
            item2 = Item.create!(name: "Goat Cheese", description: "Pretty solid on eggs", unit_price: 5000, merchant_id: merchant.id, created_at: Time.now, updated_at: Time.now)
            item3 = Item.create!(name: "American Cheese", description: "Gross", unit_price: 2000, merchant_id: merchant.id, created_at: Time.now, updated_at: Time.now)
            item4 = Item.create!(name: "Cheesey Nachos", description: "Classic", unit_price: 4000, merchant_id: merchant.id, created_at: Time.now, updated_at: Time.now)

            get "/api/v1/items/find_all?max_price=4100&min_price=1000"

            expect(response).to be_successful

            items = JSON.parse(response.body, symbolize_names: true)
            
            expect(items).to have_key(:data)
            expect(items[:data].count).to eq(3)
            expect(items[:data].class).to eq(Array)
             
            expect(items[:data][0][:attributes][:name]).to eq("Watch")
            expect(items[:data][1][:attributes][:name]).to eq("American Cheese")
            expect(items[:data][2][:attributes][:name]).to eq("Cheesey Nachos")
        end 
    end 

    describe 'sad path testing' do 
        it "throws an error if you try make an invalid request for the item find api" do
            merchant = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now)
            item1 = Item.create!(name: "Goat Cheese", description: "Pretty solid on eggs", unit_price: 5000, merchant_id: merchant.id, created_at: Time.now, updated_at: Time.now)
            item2 = Item.create!(name: "Computer", description: "Helpful for coding", unit_price: 80000, merchant_id: merchant.id, created_at: Time.now, updated_at: Time.now)   
            item3 = Item.create!(name: "American Cheese", description: "Gross", unit_price: 200, merchant_id: merchant.id, created_at: Time.now, updated_at: Time.now)
            item4 = Item.create!(name: "Cheesey Nachos", description: "Classic", unit_price: 400, merchant_id: merchant.id, created_at: Time.now, updated_at: Time.now)

            get "/api/v1/items/find"

            expect(response).to_not be_successful
            expect(response.status).to eq(400) 

            get "/api/v1/items/find?name="

            expect(response).to_not be_successful
            expect(response.status).to eq(400) 

            get "/api/v1/items/find?name=ring&min_price=50"

            expect(response).to_not be_successful
            expect(response.status).to eq(400) 

            get "/api/v1/items/find?name=ring&max_price=50"

            expect(response).to_not be_successful
            expect(response.status).to eq(400) 

            get "/api/v1/items/find?name=ring&min_price=50&max_price=250"

            expect(response).to_not be_successful
            expect(response.status).to eq(400) 
        end 

        it "throws an error if you try make an invalid request for the item find api" do
            merchant = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now)
            item1 = Item.create!(name: "Goat Cheese", description: "Pretty solid on eggs", unit_price: 5000, merchant_id: merchant.id, created_at: Time.now, updated_at: Time.now)
    
            get "/api/v1/items/find?min_price=-5"

            expect(response).to_not be_successful
            expect(response.status).to eq(400) 
            expect(response.body).to eq("{\"error\":\"Number cannot be negative\"}")
            
            get "/api/v1/items/find?max_price=-500"

            expect(response).to_not be_successful
            expect(response.status).to eq(400) 
            expect(response.body).to eq("{\"error\":\"Number cannot be negative\"}")
        end 

        it "throws an error if you try make an invalid request for the item find_all api" do
            merchant = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now)
            item1 = Item.create!(name: "Goat Cheese", description: "Pretty solid on eggs", unit_price: 5000, merchant_id: merchant.id, created_at: Time.now, updated_at: Time.now)
            item2 = Item.create!(name: "Computer", description: "Helpful for coding", unit_price: 80000, merchant_id: merchant.id, created_at: Time.now, updated_at: Time.now)   
            item3 = Item.create!(name: "American Cheese", description: "Gross", unit_price: 200, merchant_id: merchant.id, created_at: Time.now, updated_at: Time.now)
            item4 = Item.create!(name: "Cheesey Nachos", description: "Classic", unit_price: 400, merchant_id: merchant.id, created_at: Time.now, updated_at: Time.now)

            get "/api/v1/items/find_all"

            expect(response).to_not be_successful
            expect(response.status).to eq(400) 

            get "/api/v1/items/find_all?name="

            expect(response).to_not be_successful
            expect(response.status).to eq(400) 

            get "/api/v1/items/find_all?name=ring&min_price=50"

            expect(response).to_not be_successful
            expect(response.status).to eq(400) 

            get "/api/v1/items/find_all?name=ring&max_price=50"

            expect(response).to_not be_successful
            expect(response.status).to eq(400) 

            get "/api/v1/items/find_all?name=ring&min_price=50&max_price=250"

            expect(response).to_not be_successful
            expect(response.status).to eq(400) 
        end 

        it "throws an error if you try make an invalid request for the item find_all api" do
            merchant = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now)
            item1 = Item.create!(name: "Goat Cheese", description: "Pretty solid on eggs", unit_price: 5000, merchant_id: merchant.id, created_at: Time.now, updated_at: Time.now)
    
            get "/api/v1/items/find_all?min_price=-5"

            expect(response).to_not be_successful
            expect(response.status).to eq(400) 
            expect(response.body).to eq("{\"error\":\"Number cannot be negative\"}")
            
            get "/api/v1/items/find_all?max_price=-500"

            expect(response).to_not be_successful
            expect(response.status).to eq(400) 
            expect(response.body).to eq("{\"error\":\"Number cannot be negative\"}")
        end 
    end 
end 