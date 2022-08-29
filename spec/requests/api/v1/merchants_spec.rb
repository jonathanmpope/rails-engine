require 'rails_helper'

describe "Merchants API" do
  it "sends a list of merchants" do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful
  end

  xit "sends an empty list of merchants when none are present" do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful
  end
end