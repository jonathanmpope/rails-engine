# Welcome to the rails engine!

Rails Engine application acts as the back-end of an E-commerce application and serves data to the front-end via API calls. This includes RESTful API routes that perform CRUD functionality for multiple classes. Custom query API's are also available for searching by name and unit price (more details below).

# Set-up

This application runs on:
* Ruby 2.7.2
* Rails 5.2.8

## Local Setup Instructions:
* Fork and Clone the repo
* Install gem packages: bundle install
* Setup the database: rake db:{drop,create,migrate,seed} (must have Postgres installed)
* Set up the schema and populate seed data: rails db:schema:dump 

## Test Suite

To run the test suit, simply run:
```Ruby
bundle exec rspec spec
```

Simplecove will display total test coverage when running the test suite. You can find a more detailed report by running:  open coverage/index.html

## API Endpoint Data Structure Example (JSON)
 
```Ruby 
{
  "data": [
    {
      "id": "1",
        "type": "merchant",
        "attributes": {
          "name": "Mike's Awesome Store",
        }
    },
    {
      "id": "2",
      "type": "merchant",
      "attributes": {
        "name": "Store of Fate",
      }
    },
    {
      "id": "3",
      "type": "merchant",
      "attributes": {
        "name": "This is the limit of my creativity",
      }
    }
  ]
}
```

## API CRUD Queries 

* GET /api/v1/items - *returns all items*
* GET /api/v1/merchants - *returns all merchants*
* GET /api/v1/items/:id - *returns the specified item*
* GET /api/v1/merchant/:id - *returns the specified merchant*
* POST /api/v1/items - *creates an item*
Must be in the following format: 
```JSON
{
  "name": "value1",
  "description": "value2",
  "unit_price": 100.99,
  "merchant_id": 14
}
```
* PATCH /api/v1/items/:id - *update the specified item*
This API call accepts data in the same structure as the POST method (you don't need all fields)
* DELETE /api/v1/items/:id - *deletes the specified item*

## API Search Queries 

There are four custom API search queries available: 
* GET /api/vi/items/find, find a single item which matches a search term
* GET /api/vi/items/find_all, find all items which match a search term
* GET /api/vi/merchants/find, find a single merchant which matches a search term
* GET /api/vi/merchants/find_all, find all merchants which match a search term

### Valide Examples:

* GET /api/v1/merchants/find?name=Mart
* GET /api/v1/items/find?name=ring
* GET /api/v1/items/find?min_price=50
* GET /api/v1/items/find?max_price=150
* GET /api/v1/items/find?max_price=150&min_price=50

### Invalid examples:

* GET /api/v1/<resource>/find - *parameter cannot be missing*
* GET /api/v1/<resource>/find?name= - *parameter cannot be empty*
* GET /api/v1/items/find?name=ring&min_price=50 - *cannot send both name and min_price*
* GET /api/v1/items/find?name=ring&max_price=50 - *cannot send both name and max_price*
* GET /api/v1/items/find?name=ring&min_price=50&max_price=250 - *cannot send both name and min_price and max_price*

