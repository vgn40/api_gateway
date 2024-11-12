# API Gateway Service

This service acts as the main entry point for the GitHub Stats application. It provides user authentication and routes requests to the appropriate microservices.

## Features
- User authentication with JWT tokens
- SQLite database for user management
- Routes requests to the GitHub microservice
- Handles error responses
- Provides a unified API endpoint

## Setup
1. Create a `.env` file in the root directory with the following variables:
```bash
JWT_SECRET_KEY=your-secret-key  # Change this in production
PORT=5000
SQLITE_DB_PATH=users.db
GITHUB_MICROSERVICE_URL=http://github_microservice:5001
```

2. Install dependencies:
```bash
pip install -r requirements.txt
```

3. Run the service:
```bash
python app.py
```

## Docker
To build and run with Docker:
```bash
docker build -t api-gateway .
docker run -p 5000:5000 \
  -e JWT_SECRET_KEY=your-secret-key \
  -e SQLITE_DB_PATH=users.db \
  -e GITHUB_MICROSERVICE_URL=http://github_microservice:5001 \
  api-gateway
```

## API Endpoints
- GET `/` - Shows available API endpoints

### Authentication
- POST `/register` - Register a new user
  ```json
  {
    "username": "your_username",
    "password": "your_password"
  }
  ```

- POST `/login` - Login and receive JWT token
  ```json
  {
    "username": "your_username",
    "password": "your_password"
  }
  ```

### Protected Endpoints
- GET `/api/github/stats` - Retrieves GitHub statistics (requires JWT token)
  ```bash
  curl -H "Authorization: Bearer your_jwt_token" http://localhost:5000/api/github/stats
  ```

## Environment Variables
| Variable | Required | Default | Description |
|----------|----------|---------|-------------|
| `JWT_SECRET_KEY` | Yes | - | Secret key for JWT token generation |
| `PORT` | No | 5000 | Port to run the service on |
| `SQLITE_DB_PATH` | Yes | - | Path to SQLite database file |
| `GITHUB_MICROSERVICE_URL` | No | http://github_microservice:5001 | URL of the GitHub microservice |

## Database
The service uses SQLite for user management. The database file (specified by SQLITE_DB_PATH) will be automatically created when the service starts.

## Dependencies
See `requirements.txt` for a full list of Python dependencies.

## Security Notes
1. Change the JWT_SECRET_KEY in production to a secure value
2. Ensure the JWT_SECRET_KEY matches the one used in the github_microservice
3. Keep your database file secure and regularly backed up
