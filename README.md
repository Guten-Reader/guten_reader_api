# GutenReader API

[![Build Status](https://travis-ci.com/Guten-Reader/guten_reader_api.svg?branch=master)](https://travis-ci.com/Guten-Reader/guten_reader_api)  

![image](https://user-images.githubusercontent.com/18686466/72020934-1a54c600-322a-11ea-9e19-52c827510294.png)

[GutenReader](https://github.com/Guten-Reader/guten_reader_FE) is an app built in React Native for reading books hosted by [Project Gutenberg](https://www.gutenberg.org/). This API handles the downloads and CRUD functionality for users' books. GutenReader also uses a [Flask microservice](https://github.com/Guten-Reader/guten_reader_BE) to handle sentiment analysis and song recommendation based on the mood of the current page.

## Installation
NOTE: You will need to register an app with [Spotify](https://developer.spotify.com/documentation/web-api/) and save the App API Key as the environment variable: SPOTIFY_APP_API_KEY

1. Clone the repository
```
$ git clone git@github.com:Guten-Reader/guten_reader_api.git
```

2. Install dependencies
```
$ bundle install
```

3. Set up the database
```
$ createdb guten-reader-api_development
$ createdb guten-reader-api_test
$ rails db:{create,migrate,seed}
$ rails db:{create, migrate} RAILS_ENV=test
```

4. Run the server
```
$ rails s
```

4. Run the tests
```
$ rspec
```

## Base Url
`https://guten-server.herokuapp.com/`

## Endpoints

1. [GET access_token](https://github.com/Guten-Reader/guten_reader_api#get-access_token)

2. [GET single user_books](https://github.com/Guten-Reader/guten_reader_api#get-single-user_books)

3. [POST user_books](https://github.com/Guten-Reader/guten_reader_api#post-user_books)

4. [GET user_books (all books)](https://github.com/Guten-Reader/guten_reader_api#get-user_books-all-books)

5. [UPDATE user_books (by user_id, book_id)](https://github.com/Guten-Reader/guten_reader_api#update-user_books-by-user_id-book_id)

6. [DELETE user_books (by user_id, book_id)](https://github.com/Guten-Reader/guten_reader_api#delete-user_books-by-user_id-book_id)

7. [PATCH user (by user_id)](https://github.com/Guten-Reader/guten_reader_api#patch-user-by-user_id)

8. [GET user (by user_id)](https://github.com/Guten-Reader/guten_reader_api#get-user-by-user_id)

### GET access_token 

`GET api/v1/access_token/:user_id`

[Example Request](https://guten-server.herokuapp.com/api/v1/access_token/1)

**Description:** When a user's access_token expires, a GET request can be sent to `/access_token/:user_id`. The user's ID is included in the params. If the request is successful, a valid access_token is returned with the status code 200. If the request fails, an error message with the status code 404 is returned. **Please note, access_token expires hourly**

**Request**
```
GET /api/v1/access_token/:user_id
Content-Type: application/json
Accept: application/json
```

**Successful Response**

```
status: 200

{
    "access_token": "BQBqxYOa2N0AILh2hu_sTtfhP_bwN3EPT4e2jCpAn69ytIeUqgSf1xzjIkLtfSFTts_o4irOlmMuLIeG_DS-4iiQZ-W6XlRilSiy3FaSrbzpbUaaDhSkvpCAkYmqwQoA9gJvdSbIRY0jkiL_ADIQaGPXw7p7HBKo_Ao"
}
```

**Unsuccessful Response**
```
status: 404

{
    "error": "Could not find record with user_id: 123"
}
```


### GET single user_books

`GET api/v1/users/:id/books/:id`

**Description:** A user clicks on one of their checked-out book. A GET request is sent to `/users/:id/books/:id`. The user ID and book ID is included in the URL. The book ID is the ID of the book from the books table, not the Gutenberg ID. If the request is successful, you will receive a JSON response with the user's current_page and the paginated text from the request book. The paginated text is returned in an array, with each index of the array as one book page. You will also receive a 200 status code. If the request is not successful, you will receive the status code 404.

Notes on pagination
- Paginated pages include `\r\n\` from original text
- Each page is roughly 600 characters

**Request**
```
GET /api/v1/users/:id/books/:id
Content-Type: application/json
Accept: application/json
```

**Successful Response**

```
status: 200

{ "data": {
        "current_page": 0,
        "book": [
            "This is example text for page 1",
            "This is example text for page 2",
            "This is example text for page 3",
            ...
            "This is example text for page 500"
          ]
        }
}  
```

**Unsuccessful Response**
```
status: 404

{
    "error": "Could not find record with user_id: user_id, book_id: book_id"
}
```


### POST user_books

`POST api/v1/users/:id/books`

**Description:** A user clicks button from search page which sends a POST request to the endpoint `/api/v1/users/:id/books`. You must include the book's `author`, `title`, and `guten_id` in the body. A `img_url` is optional in the body of the request.  If the POST request is successful, you will see a JSON response with the user_id and book_id and receive a 201 status code. If the POST request is unsuccessful, you will receive a 400 status code.

**Request**
```
POST /api/v1/users/:id/books
Content-Type: application/json
Accept: application/json

{
  "guten_id": "123453",
  "title": "example title",
  "author": "example author"
}

```
**Successful Response**
```
status: 201

{
  "Success": "{Title} has been added to user: {user_id} !"
}
```

**Unsuccessful Response**
```
status: 400

{
   "error": "{Title} could not be added to user: {user_id}."
}
```

### GET user_books (all books)

`GET api/v1/users/:id/books/`

**Description:** A user visits their 'library page'. This endpoint will retrieve a list
of all their books. It will return an empty array if they have no books. It will return
status 404 if the user is not found.

**Request**
```
GET /api/v1/users/:user_id/books
```
**Successful Response**
```
status: 200

{ "books": [
         { "id": 1,
            "guten_id": 123456,
            "title": "example title",
            "author": "example author",
            "current_page": 0 },
          {  "id": 2,
            "guten_id": 789012,
            "title": "example title",
            "author": "example author",
            "current_page": 24 },
          {  "id": 3,
            "guten_id": 345678,
            "title": "example title",
            "author": "example author",
            "current_page": 42 }
          ]}
```

**Unsuccessful Response**
```
status: 404

{
   "error": "User could not be found."
}
```

### UPDATE user_books (by user_id, book_id)
`PATCH api/v1/users/:user_id/books/:book_id`

**Description:** You make a PATCH request to the endpoint ``api/v1/users/:user_id/books/:book_id?current_page=[CURRENT_PAGE_NUMBER]``. You must include the current page in the query params of the URI with they key 'current_page'. If the PATCH request is successful, you will see a JSON response with the updated current_page and receive a 200 status code. If the PATCH does not have query param current_page, you will receive a 400 status code.  If the user_book is not found, you will receive a 404 status code.

**Request**
```
PATCH api/v1/users/:user_id/books/:book_id?current_page={page_num}
```
**Successful Response**
```
PATCH api/v1/users/5/books/3?current_page=42
status: 200

{
  id: 1,
  user_id: 5,
  book_id: 3,
  current_page: 42,
  created_at: "2019-12-19T20:15:21.536Z",
  updated_at: "2019-12-19T20:15:21.536Z"
}
```

**Unsuccessful Responses**
```
status: 404

{
   "error": "Could not find record with user_id: {user_id}, book_id: {book_id}"
}
```

```
status: 404

{
   "error": "Missing query param current_page"
}
```

### DELETE user_books (by user_id, book_id)
`DELETE api/v1/users/:user_id/books/:book_id`

**Description:** Send a DELETE request to the endpoint `api/v1/users/:user_id/books/:book_id` to remove a book from a users library. If the DELETE request is successful, you will see a No Content response, 204 status code. If the DELETE request is unsuccessful, I will receive a 404 status code.

**Request**
```
DELETE api/v1/users/:user_id/books/:book_id
```
**Successful Response**
```
status: 204
```

**Unsuccessful Response**

```
status: 404

{
   "error": "Could not find record with user_id: {user_id}, book_id: {book_id} "
}
```

### PATCH user (by user_id)
`PATCH api/v1/users/:user_id`

**Description:** Send a PATCH request to the endpoint `api/v1/users/:user_id` with the updated user settings in the request body. If the PATCH request is successful, you will see a No Content response, 204 status code. If the PATCH request is unsuccessful, I will receive a 404 status code if user is not found or 400 status code if params are missing from the body.

**Request**

`
PATCH api/v1/users/:user_id
 
{ 
  "music_genre": "piano", 
  "dyslexic_font":  true, 
  "dark_mode": true, 
  "font_size": 20
}

`

**Successful Response**

```
status: 204
```

**Unsuccessful Responses**
```
status: 404

{ 
   "error": "Could not find user with user_id: {user_id}"
}
```

```
status: 400

{ 
   "error": "Missing required body parameters: dark_mode and font_size"
}
```

### GET user (by user_id)
`GET api/v1/users/:user_id`

**Description:** Send a GET request to the endpoint `api/v1/users/:user_id` . If the GET request is successful, you receive a JSON response with the user's preferred setting and the status code 200. If the GET request is unsuccessful, I will receive a 404 status code if user is not found.


``` 
GET api/v1/users/:user_id
```

**Successful Response**
```
status: 200 

{ 
  "music_genre": "classical", 
  "dyslexic_font":  false, 
  "dark_mode": true, 
  "font_size": 10
}

```

**Unsuccessful Responses**
```
status: 404

{ 
   "error": "Could not find user with user_id: {user_id}"
}
```

## Contributors
- **Mack Halliday**
    - [GitHub](https://github.com/MackHalliday)
    - [LinkedIn](https://www.linkedin.com/in/mackhalliday/)
- **Fenton Taylor**
    - [GitHub](https://github.com/fentontaylor)
    - [LinkedIn](https://www.linkedin.com/in/fenton-taylor-006057122/)
