### Base Url
`https://guten-server.herokuapp.com/`

### Endpoints

#### POST user_books

`POST /users/:id/books`

**Description:** A user clicks button from search page

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