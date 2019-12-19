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

#### UPDATE user_books (by id, guten_id)
`PATCH /users/:id/books/:guten_id`

#### DELETE user_books (by id, guten_id)
`DELETE /users/:id/books/:guten_id`

#### GET user_book (by id, guten_id)
`GET /users/:id/books/:guten_id`