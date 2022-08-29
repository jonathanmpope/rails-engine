FactoryBot.define do
    factory :item do
      name { Faker::Books::Dune.character }
      description { Faker::Quotes::Shakespeare.hamlet_quote }
      unit_price { Faker::Number.within(range: 1..100_000) }
      merchant { nil }
    end
end