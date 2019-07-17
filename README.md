# PetfulLife API

## Introduction

This RESTful JSON API built in Ruby on Rails (RoR) 5.2 is the back end for PetfulLife, a virtual assistant for your pet's life. The [front end repository](https://github.com/petful-life/petfulLife) is built in React Native, and the app is deployed to the Google Play Store [here](https://futuredeployedlink82345923874234.com). This app is the capstone project at [Turing School of Software and Design](https://turing.io/) for the four [core contributors](#core-contributors) and an example of what a full stack team of Turing students can build.

## Initial Setup

Please make sure you have Rails 5.2 installed in your ruby enviornment. If you do not have Ruby or Rails installed, some setup directions can be found [here](https://guides.rubyonrails.org/getting_started.html).

In order to run this API on your local maching, please fork and clone this repository, then from a terminal within the project directory run the following commands:

`bundle install`

`rails s`

The app is configured to run on `localhost:3000`.

A convenient way to interact with an API-only rails app is through [postman](https://www.getpostman.com/).

## How to use

A sample request could be GET `localhost:3000/api/v1/products`.

###Endpoints:

### Users
Reaching user Endpoints will use ```/api/v1/users```

users have complete CRUD functionality

#####GET user information
In order to receive a user you are required to know that user's ID

This will return a user's information **minus** their password information for security purposes

Request:

```GET /api/v1/users/:id```

Response:

Status: 200

```
{"data"=>
	{"id"=>"20",
	 "type"=>"user",
	 "attributes"=>
	 	{"id"=>20,
	 	 "username"=>"bob"}
	 }
}
```

Should there be no present user the Response will return

```status: 404 {error: User not found}```


#####POST user information
When posting to the endpoint all fields are required

Request:

```POST /api/v1/users```

Body:

Status: 201

```
{
	"username": 'USERNAME',
	"email": 'EMAIL',
	"password": 'PASSWORD',
	"password_confirmation", 'PASSWORD_CONFIRMATION'
}
```

Response:

```
{"data"=>
	{"id"=>"20",
	 "type"=>"user",
	 "attributes"=>
	 	{"id"=>20,
	 	 "username"=>"bob"}
	 }
}

```

If there is a failure the return of this request will give explicit errors as to the problem. Likely errors include missing fields or mismatched passwords.

##### PATCH user information
When a user wishes to update their information they are able to do so completely or with single field requests.

The user ID is required to update a user's information

Request: ```PATCH /api/v1/users/:id```

Body:

Again This request may contain one or all field in the body, the exception if the ```password``` and ```password_confirmation``` fields.

```
{
	"username": 'USERNAME',
	"email": 'EMAIL',
	"password": 'PASSWORD',
	"password_confirmation", 'PASSWORD_CONFIRMATION'
}
```

Response:

Status: 201

```
{"data"=>
	{"id"=>"20",
	 "type"=>"user",
	 "attributes"=>
	 	{"id"=>20,
	 	 "username"=>"bob"}
	 }
}

```

Should any of the field be incorrect or if the passwords are mismatched the response will be explicit error messages regarding the failure. with a status of  400

##### DELETE user information
When a user wishes to delete the user they are required to have the ID of that user.

**This is permanent and *can not* be undone**

Request: ```DELETE /api/v1/users/:ID```

Response: ```Status: 204```

Should it fail the response will be ```status: 404 {error: 'user not found'}```


#### Products

**`GET /api/v1/products`**:  

Upon success:  
Status -- 200
Return all products, serialized as:  
```
[
    {
        "id": 1,
        "name": "Purina Puppy Chow",
        "avg_rating": 4.74,
        "avg_price": 25.91
        "createdAt": "2019-07-02T19:15:59.841Z",
        "updatedAt": "2019-07-02T19:15:59.841Z"
    },
    {
        "id": 2,
        "name": "Purina Kitten Pate",
        ...
    },
    ...
]
```

## Tests

The test suite for this project is rspec. In order to run the suite, after following the [initial setup](#initial-setup) instructions above, run the following from a terminal in the root project directory:

`bundle exec rspec`

## Core Contributors

#### Back End Team:
[Vincent Provenzano](https://github.com/Vjp888)
[Jeremy Bennett](https://github.com/jaxjafinpapau)

#### Front End Team:
[Adam Niedzwiecki](https://github.com/AdamN8142)
[Lauren Boyer](https://github.com/lboyer4)

## How to Contribute

Please follow the [initial setup](#initial-setup) instructions, then when you have completed your contribution, create a pull request to the PetfulLife API master branch.

## Database Schema

![mock_search](db_schema.png)

## Tech Stack

- Ruby on Rails 5.2
