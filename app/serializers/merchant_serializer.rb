class MerchantSerializer
  include JSONAPI::Serializer
  attributes :name
  # set_id { nil }
  #  has_many :items
end
