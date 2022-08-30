class Merchant < ApplicationRecord 
    has_many :items 

    validates_presence_of :name

    def self.find_by_name(name)
        merchants = where("name ILIKE ?", "%#{name}%")
        merchants == nil ?  { data: {} } :  MerchantSerializer.new(merchants)
    end
end 