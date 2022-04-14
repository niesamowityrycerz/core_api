# README

Core_api and exchange_rates engine

Things you may want to cover:

* git clone
* git submodule init
* git submodule update

* Ruby version
  3.0.1

* How to run the test suite
  bundle exec rspec

* Core_API endpoints documentation:

```
POST /api/v1/users

Request

{
  "name": <string; max. 50 chars; required>,
  "email": <string; must have an email format; required>,
  "total_orders_pln": <float; greater than 0.0; less than 100000000.00; optional>
}

Response(no errors)

{
    "user": {
        "total_orders_eur": "45316408.01",
        "id": 4,
        "name": "mike",
        "email": "test@gmail.com",
        "total_orders_pln": "9753854.5",
        "created_at": "2022-04-13T23:29:33.717Z",
        "updated_at": "2022-04-13T23:29:44.376Z"
    },
    "status": "success"
}

Response(when errors)

{
    "errors": {
        "name": [
            "is missing"
        ],
        "email": [
            "is already taken"
        ]
    },
    "status": 400
}

___________________________________________________________________________

GET /api/v1/users

Request - parameters are not specified

Response(when at least one user exists)

{
    "users": [
        {
            "id": 4,
            "name": "mike",
            "email": "test@gmail.com",
            "total_orders_pln": "9753854.5",
            "total_orders_eur": "45316408.01",
            "created_at": "2022-04-13T23:29:33.717Z",
            "updated_at": "2022-04-13T23:29:44.376Z"
        }
    ]
}

Response(when users don't exist)

{
    "users": "There are no users.Go ahead and create one!"
}

___________________________________________________________________________

GET /api/v1/users/:id

Request

Accept url parameter or 
{
  "id": <user id>
}

Response(when user with that id exists)

{
    "user": {
        "total_orders_eur": "45316408.01",
        "id": 4,
        "name": "mike",
        "email": "test@gmail.com",
        "total_orders_pln": "9753854.5",
        "created_at": "2022-04-13T23:29:33.717Z",
        "updated_at": "2022-04-13T23:29:44.376Z"
    },
    "status": "success"
}

Response(when user does not exist)

{
    "errors": {
        "user": [
            "does not exist"
        ]
    },
    "status": 400
}
```


* Exchange rates engine endpoints are mounted at: /api/v1/users/:id/exchange_rates

```
GET /api/v1/users/:id/exchange_rates

Response(external service works)

{
    "user": {
        "total_orders_eur": "200582752.66",
        "id": 5,
        "name": "mike",
        "email": "test@gmail.com",
        "total_orders_pln": "43173214.09",
        "created_at": "2022-04-14T00:30:52.216Z",
        "updated_at": "2022-04-14T00:34:15.514Z"
    },
    "status": "success"
}

Response(when external service does not respond )

{
    "error": 'Service is unavailable',
    "status": "failure"
}

Response(when external service has missing data)

{
    "error": 'Service is missing data',
    "status": "failure"
}

Response(when request is somehow invalid)

{
    "error": 'Invalid request',
    "status": "failure"
}

```




