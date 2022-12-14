require 'rails_helper'

describe "Items API" do
    describe 'happy path testing' do 
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

        it "sends data for a single item" do
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

        it "lets you create an item" do
            merch1id = create(:merchant).id
            item_params = ({
                    name: 'Big wheel-o-cheese',
                    description: 'Yellow and tasty',
                    unit_price: 99.99,
                    merchant_id: merch1id
                    })
            headers = {"CONTENT_TYPE" => "application/json"}

            post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)
            
            created_item = Item.last

            expect(response).to be_successful
            
            expect(created_item.name).to eq('Big wheel-o-cheese')
            expect(created_item.description).to eq('Yellow and tasty')
            expect(created_item.unit_price).to eq(99.99)
            expect(created_item.merchant_id).to eq(merch1id)

            item = JSON.parse(response.body, symbolize_names: true)

            expect(item).to have_key(:data)
            expect(item[:data].class).to eq(Hash)

            expect(item[:data]).to have_key(:id)
            expect(item[:data][:id]).to be_a(String)

            expect(item[:data]).to have_key(:type)
            expect(item[:data][:type]).to eq("item")

            expect(item[:data]).to have_key(:attributes)

            expect(item[:data][:attributes]).to have_key(:name)
            expect(item[:data][:attributes][:name]).to eq('Big wheel-o-cheese')

            expect(item[:data][:attributes]).to have_key(:description)
            expect(item[:data][:attributes][:description]).to eq('Yellow and tasty')
                
            expect(item[:data][:attributes]).to have_key(:unit_price)
            expect(item[:data][:attributes][:unit_price]).to eq(99.99)

            expect(item[:data][:attributes]).to have_key(:merchant_id)
            expect(item[:data][:attributes][:merchant_id]).to eq(merch1id)

            expect(item[:data][:attributes]).to_not have_key(:created_at)
            expect(item[:data][:attributes]).to_not have_key(:updated_at)
        end

        it "lets you update an item" do
            merch1id = create(:merchant).id
            item = create(:item, merchant_id: merch1id)
            previous_name = item.name 

            item_params = {
                    name: 'Big wheel-o-cheese',
                    description: 'Yellow and tasty',
                    unit_price: 99.99,
                    merchant_id: merch1id
                    }
            headers = {"CONTENT_TYPE" => "application/json"}

            patch "/api/v1/items/#{item.id}", headers: headers, params: JSON.generate({item: item_params})
            updated_item = Item.find_by(id: item.id)
            
            expect(response).to be_successful
            expect(updated_item.name).to_not eq(previous_name)
            expect(updated_item.name).to eq("Big wheel-o-cheese")

            item = JSON.parse(response.body, symbolize_names: true)

            expect(item).to have_key(:data)
            expect(item[:data].class).to eq(Hash)

            expect(item[:data]).to have_key(:id)
            expect(item[:data][:id]).to be_a(String)

            expect(item[:data]).to have_key(:type)
            expect(item[:data][:type]).to eq("item")

            expect(item[:data]).to have_key(:attributes)

            expect(item[:data][:attributes]).to have_key(:name)
            expect(item[:data][:attributes][:name]).to eq('Big wheel-o-cheese')

            expect(item[:data][:attributes]).to have_key(:description)
            expect(item[:data][:attributes][:description]).to eq('Yellow and tasty')
                
            expect(item[:data][:attributes]).to have_key(:unit_price)
            expect(item[:data][:attributes][:unit_price]).to eq(99.99)

            expect(item[:data][:attributes]).to have_key(:merchant_id)
            expect(item[:data][:attributes][:merchant_id]).to eq(merch1id)

            expect(item[:data][:attributes]).to_not have_key(:created_at)
            expect(item[:data][:attributes]).to_not have_key(:updated_at)
        end
        
        it "can destroy an item" do
            merch1id = create(:merchant).id
            item = create(:item, merchant_id: merch1id)

            expect(Item.count).to eq(1)

            delete "/api/v1/items/#{item.id}"

            expect(response).to be_successful
            expect(Item.count).to eq(0)
            expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
            expect(response.status).to eq(204) 
        end

         it "can destroy an item and an invoice if it's the only item" do
            merchant = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now)
            customer = Customer.create!(first_name: "John", last_name: "Smith", created_at: Time.now, updated_at: Time.now)
            invoice = Invoice.create!(status: :completed, created_at: "2022-07-28 09:54:09 UTC", updated_at: Time.now, customer_id: customer.id )
            item = Item.create!(name: "Watch", description: "Always a need to tell time", unit_price: 3000, merchant_id: merchant.id, created_at: Time.now, updated_at: Time.now)
            invoice_item = InvoiceItem.create!(item_id: item.id, invoice_id: invoice.id, quantity: 1, unit_price: item.unit_price, created_at: Time.now, updated_at: Time.now)

            delete "/api/v1/items/#{item.id}"

            expect(response).to be_successful
            expect(Item.count).to eq(0)
            expect(Invoice.count).to eq(0)
            expect{Invoice.find(invoice.id)}.to raise_error(ActiveRecord::RecordNotFound)
            expect(response.status).to eq(204) 
        end
    end 
    
    describe 'sad path testing' do 
        it "tells you if you tried to retrieve an item that doesn't exist" do\
            get "/api/v1/items/99"

            expect(response).to_not be_successful
            expect(response.status).to eq(404) 
        end 

        it "doesn't let you create an item if you are missing data" do
            merch1id = create(:merchant).id
            item_params = ({
                    name: 'Big wheel-o-cheese',
                    unit_price: 99.99,
                    merchant_id: merch1id
                    })
            headers = {"CONTENT_TYPE" => "application/json"}

            post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)
               
            expect(response).to_not be_successful
            expect(response.status).to eq(422) 
        end 

        it "allows you to create an item with extra data" do
            merch1id = create(:merchant).id
            item_params = ({
                    name: 'Big wheel-o-cheese',
                    description: 'Yellow and tasty',
                    origin: 'milky way galaxy',
                    unit_price: 99.99,
                    merchant_id: merch1id
                    })
            headers = {"CONTENT_TYPE" => "application/json"}

            post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)

            expect(response).to be_successful
            expect(response.status).to eq(201) 

            created_item = Item.last
            
            expect(created_item.name).to eq('Big wheel-o-cheese')
            expect(created_item.description).to eq('Yellow and tasty')
            expect(created_item.unit_price).to eq(99.99)
            expect(created_item.merchant_id).to eq(merch1id)
        end 

        it "won't let you update an item without data" do
            merch1id = create(:merchant).id
            item = create(:item, merchant_id: merch1id)
            previous_name = item.name 

            item_params = { name: nil }
            headers = {"CONTENT_TYPE" => "application/json"}

            patch "/api/v1/items/#{item.id}", headers: headers, params: JSON.generate({item: item_params})
            updated_item = Item.find_by(id: item.id)
        
            expect(response).to_not be_successful
            expect(updated_item.name).to eq(previous_name)
            expect(updated_item.name).to_not eq(nil)
        end 

        it "won't let you try to update an item that doesn't exist" do
            merch1id = create(:merchant).id
            item = create(:item, merchant_id: merch1id)
            previous_name = item.name 

            item_params = { name: "hello" }
            headers = {"CONTENT_TYPE" => "application/json"}

            patch "/api/v1/items/99", headers: headers, params: JSON.generate({item: item_params})
            updated_item = Item.find_by(id: item.id)
        
            expect(response).to_not be_successful
            expect(updated_item.name).to eq(previous_name)
            expect(updated_item.name).to_not eq(nil)
        end 

        it "throws an error if you try to destroy an item that doesn't exist" do
            delete "/api/v1/items/99"

            expect(response).to_not be_successful
            expect(response.status).to eq(404) 
        end
    end 
end