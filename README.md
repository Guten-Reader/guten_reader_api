### Base Url
`https://guten-server.herokuapp.com/`

### Endpoints

### GET single user_books

`GET /users/:id/books/:id`

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


#### POST user_books

`POST /users/:id/books`

**Description:** A user clicks button from search page which sends a POST request to the endpoint `/api/v1/users/:id/books`. You must include the book's `author`, `title`, and `guten_id` in the body. A `img_url` is optional in the body of the request.  If the POST request is successful, you will see a JSON response with the user_id and book_id and receive a 201 status code. If the POST request is unsuccessful, you will receive a 400 status code.

**Request**
```
POST /api/v1/users/:id/books
Content-Type: application/json
Accept: application/json

{
  "guten_id": "123453",
  "title": "example title",
  "author": "example author",
  "img_url": **OPTIONAL***
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

#### GET user_books (all books)

`GET /users/:id/books/`

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
            "author": "example author" },
          {  "id": 2,
            "guten_id": 789012,
            "title": "example title",
            "author": "example author" },
          {  "id": 3,
            "guten_id": 345678,
            "title": "example title",
            "author": "example author" }
          ]}
```

**Unsuccessful Response**
```
status: 404

{
   "error": "User could not be found."
}
```

#### UPDATE user_books (by user_id, book_id)
`PATCH /users/:user_id/books/:book_id`
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

#### DELETE user_books (by user_id, book_id)
`DELETE /users/:user_id/books/:book_id`

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

#### GET user_book (by user_id, book_id)
`GET /users/:user_id/books/:book_id`
