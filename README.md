# Store Locator API

A RESTful API written in Rails that provides functionality for a store locator. Complete with CRUD functionality on both locations and business hours as well as full search functionality by current location (coordinates) and address.

**The main purpose of this project is to learn Ruby and Rails. It is a lighter-weight version of an API I wrote as a Laravel package at my current job.**

## Roadmap

- [x] Implement CRUD functionality for locations
- [x] Implement all fields for locations
- [x] Implement search by coordinates
- [x] Implement search by address (will require integration with the Google Geocoding API)

## API Documentation

In the following section, we will explore the various endpoints and parameters for the API.

### All locations

Returns JSON data containing every location in the database.

* **URL**
  `/locations`
* **Method**
  `GET`
* **URL Params**
  **Optional**
  `search=[query]`
  Search for locations within a 20 mile radius of the given query.
  The `query` can be one of two values:
  1. A geocodeable string, such as an address or city.
  2. A set of coordinates: `33.6595,-117.9988`. This is useful in cases where the
  client has access to the user's location via coordinates and avoids the need
  to hit an API service before running the database query.
* **Data Params**
  None
* **Success Response**
  * **Code:** 200<br>
    **Content:** `[{"name": "Dimension C-132",...},...]`
* **Error Response**
  There is no error response for this request. If no locations are present, empty JSON will be returned.

### Show Location

Returns JSON for a single location resource.

* **URL**
  `/locations/:id`
* **Method**
  `GET`
* **URL Params**
  None
* **Data Params**
  None
* **Success Response**
  * **Code:** 200<br>
    **Content:** `{"name": "Dimension C-132",...}`
* **Error Response**
  * **Code:** 404<br>
    **Content:** `{"message": "Couldn't find Location with 'id'=:id"}`

### Create Location

Create a new location resource.

* **URL**
  `/locations`
* **Method**
  `POST`
* **URL Params**
  None
* **Data Params**
  **Required:**
  `name=[string]`
  **Optional:**
  `address=[string]`
  `address_2=[string]`
  `city=[string]`
  `state=[string:2]`
  `zip=[string]`
  `latitude=[float]`
  `longitude=[float]`

  The `latitude` and `longitude` columns will automatically be calculated if the `address` is provided in the request. It is recommended to provide at least `address` and `zip` to ensure proper geocoding for the location's coordinates.
* **Success Response**
  * **Code:** 201<br>
    **Content:** `{"name": ":name",...}`
* **Error Response**
  * **Code:** 422<br>
    **Content:** `{"message": "Validation failed: Name can't be blank"}`

### Update Location

Update an existing location resource.

* **URL**
  `/locations/:id`
* **Method**
  `PATCH`
* **URL Params**
  None
* **Data Params**
  **Optional:**
  `name=[string]`
  `address=[string]`
  `address_2=[string]`
  `city=[string]`
  `state=[string:2]`
  `zip=[string]`
  `latitude=[float]`
  `longitude=[float]`

  The `latitude` and `longitude` columns will automatically be _re-calculated_ if the `address` was updated. It is recommended to provide at least `address` and `zip` to ensure proper geocoding for the location's coordinates.
* **Success Response**
  * **Code:** 204<br>
    **Content:** None
* **Error Response**
  * **Code:** 404<br>
    **Content:** `{"message": "Couldn't find Location with 'id'=:id"}`

### Destroy Location

Create a new location resource.

* **URL**
  `/locations/:id`
* **Method**
  `DELETE`
* **URL Params**
  None
* **Data Params**
  None
* **Success Response**
  * **Code:** 204<br>
    **Content:** None
* **Error Response**
  * **Code:** 404<br>
    **Content:** `{"message": "Couldn't find Location with 'id'=:id"}`