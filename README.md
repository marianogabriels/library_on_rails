# Library on rails

## Overview
This is a app for managing a library system, including operations for books and borrowings.

## Requirements
- Ruby 3.3.1
- PostgreSQL

## Setup

1. **Clone the repository:**
   ```bash
   git clone git@gitlab.com:marianogabriels/library_on_rails.git
   ```

2. **Install dependencies:**
   ```bash
   bundle install
   ```

3. **Database setup:**
   ```bash
   docker-compose up
   rails db:create
   rails db:migrate
   rails db:seed
   ```

4. **Start the server:**
   ```bash
   rails server
   ```

## API Documentation

### Books

- **List all books**
  - `GET /api/v1/books`
  - Response: JSON array of books

- **Get a specific book**
  - `GET /api/v1/books/:id`
  - Response: JSON object of the book

- **Create a new book**
  - `POST /api/v1/books`
  - Params: `title`, `author`, `genre`, `isbn`, `total_copies`
  - Response: JSON object of the created book

- **Update a specific book**
  - `PATCH/PUT /api/v1/books/:id`
  - Params: `title`, `author`, `genre`, `isbn`, `total_copies`
  - Response: JSON object of the updated book

- **Delete a specific book**
  - `DELETE /api/v1/books/:id`
  - Response: No content

### Borrows

- **List all borrows**
  - `GET /api/v1/borrows`
  - Response: JSON array of borrows

- **Get a specific borrow**
  - `GET /api/v1/borrows/:id`
  - Response: JSON object of the borrow

- **Create a new borrow**
  - `POST /api/v1/borrows`
  - Params: `user_id`, `book_id`, `due_at`
  - Response: JSON object of the created borrow

- **Mark a borrow as returned**
  - `PATCH /api/v1/borrows/:id/mark_as_returned`
  - Response: JSON object of the updated borrow with `returned_at` timestamp

- **Delete a specific borrow**
  - `DELETE /api/v1/borrows/:id`
  - Response: No content

## Running Tests

To run the test suite, execute:

```bash
bundle exec rspec
```
