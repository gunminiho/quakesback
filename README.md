# README


# Frogmi Challenge

This repo is made for a challenge with Frogmi.

this backend has 1 task: earthquakesback:get_earthquakes 
which fetch all data from : https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.geojson and store it on postgreSQL DB.






## Documentation

This backend has 2 endpoints:

1.- GET '/api/features' :

retrieves all data paginated and sorted by magnitude type

URL= ".../api/features?page=2&per_page=1000&mag_type[]=md"

mag_type : is an array of strings with many options like: [md, ml, ms, mw, me, mi, mb, mlg] and it's optional.

page : integer which represents which page you want to display

per_page: integer which represent how many items you want per page

2.- POST '.../api/features/:feature_id/comments'

send a comment for a specific feature in DB.

:feature_id = feature_id which passed thru params and a foreign key pointing to earthquake table containing a specific feature.

body = contains text received as a comment, must be at least 10 characters long and can not be null nor blank

## API Reference

#### Get all quakes

```http
  GET /api/features
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `page` | `integer` | **Required**. returns specific page  |
| `per_page` | `integer` | **Required**. sets #items per page  |
| `mag_type` | `Array(string)` | **Optional**. filter by mag_type  |

#### Post comment

```http
  /api/features/:feature_id/comments
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `body`      | `text` | **Required**. comment for specific feature |
| `feature_id`      | `text` | **Required**. indetifier for specific feature |


## Run Locally

Clone the project

```bash
  git clone https://github.com/gunminiho/quakesback.git
```

Go to the project directory

```bash
  cd quakesback
```

Install dependencies

```bash
  bundle install
```

Create DB

```bash
  rails db:create
  rails db:migrate
```

Start the server

```bash
  rails server
```


## Tech Stack

**Server:** Ruby on Rails, PostgreSQL

