# Universities API

This API provides a robust system to manage universities and their associated contact emails. It includes endpoints for creating, updating, retrieving, and deleting universities and contact emails, with built-in support for pagination, sorting, and search.

## Features

- CRUD operations for universities and their contact emails.
- Pagination, sorting, and search for universities.
- Validation of input data.
- Supports nested attributes for contact emails.

---

## Getting Started

### Prerequisites

Ensure you have the following installed:

- Ruby (version 3.2.2)
- Rails (version 7.x)
- PostgreSQL
- Bundler (`gem install bundler`)

### Installation

1. Clone the repository:

   ```bash
   git clone <repository_url>
   cd <repository_name>
   ```

2. Install dependencies:

   ```bash
   bundle install
   ```

3. Configure the database:

   Copy the template database configuration file:

   ```bash
   cp config/database.template.yml config/database.yml
   ```

   Update the `config/database.yml` file with your PostgreSQL credentials.

4. Set up the database:

   ```bash
   rails db:create db:schema:load
   ```

5. Run the server:

   ```bash
   rails server
   ```

---

## API Endpoints

### Universities

| Method        | Endpoint                   | Description                              |
| ------------- | -------------------------- | ---------------------------------------- |
| `GET`         | `/api/v1/universities`     | List universities (pagination & filters) |
| `GET`         | `/api/v1/universities/:id` | Retrieve details of a university         |
| `POST`        | `/api/v1/universities`     | Create a new university                  |
| `PATCH`/`PUT` | `/api/v1/universities/:id` | Update an existing university            |
| `DELETE`      | `/api/v1/universities/:id` | Delete a university                      |

---

### Example Requests

#### List Universities

**GET** `/api/v1/universities`

Query Parameters:

- `search` (string, optional): Search by university name.
- `sort_by` (string, optional): Field to sort by (`name`).
- `sort_order` (string, optional): Sort direction (`asc` or `desc`).
- `per_page` (integer, optional): Number of universities per page.
- `page` (integer, optional): Page number.

Response:

```json
{
  "data": [
    {
      "id": 1,
      "name": "University A",
      "location": "New York",
      "website_url": "http://universitya.com",
      "contact_emails": []
    },
    {
      "id": 2,
      "name": "University B",
      "location": "San Francisco",
      "website_url": "http://universityb.com",
      "contact_emails": []
    }
  ],
  "meta": {
    "current_page": 1,
    "total_pages": 1,
    "total_count": 2
  }
}
```

#### Create a University

**POST** `/api/v1/universities`

Request Body:

```json
{
  "university": {
    "name": "New University",
    "location": "Los Angeles",
    "website_url": "http://newuniversity.com",
    "contact_emails_attributes": [{ "email": "info@newuniversity.com" }]
  }
}
```

Response:

```json
{
  "message": "University created successfully",
  "university": {
    "id": 3,
    "name": "New University",
    "location": "Los Angeles",
    "website_url": "http://newuniversity.com",
    "contact_emails": [{ "id": 1, "email": "info@newuniversity.com" }]
  }
}
```

---

## Running Tests

To run the test suite, execute:

```bash
bundle exec rspec
```

---

## Deployment

1. Ensure all environment variables are correctly set for the production environment.
2. Precompile assets (if necessary):

   ```bash
   rails assets:precompile
   ```

3. Deploy to your server or platform of choice.

---

## Contributing

1. Fork the repository.
2. Create a feature branch (`git checkout -b feature-name`).
3. Commit your changes (`git commit -m 'Add feature'`).
4. Push to the branch (`git push origin feature-name`).
5. Open a pull request.

---

## Questions or Support

For any questions or issues, please contact the project maintainer.
