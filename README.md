# Birthday Application

A simple full-stack birthday greeting app with a Node.js backend, a frontend UI, and Terraform-based infrastructure configuration.

## Project Structure

- backend/ - Express.js API and database access layer
- frontend/ - Static frontend served by Nginx
- database/ - SQL initialization script for the MySQL database
- terraform/ - Infrastructure as Code for AWS resources
- .github/workflows/ - CI/CD workflow for Terraform deployment

## Features

- Fetches a birthday wish from a MySQL database
- Serves the data through a REST API
- Includes a basic frontend page to display the message
- Deploys infrastructure with Terraform

## Prerequisites

- Node.js and npm
- MySQL database
- Docker (optional, if you want to run the app in containers)
- Terraform (for infrastructure deployment)

## Backend Setup

1. Navigate to the backend folder:
   ```bash
   cd backend
   ```
2. Install dependencies:
   ```bash
   npm install
   ```
3. Create a `.env` file with your database configuration:
   ```env
   PORT=3000
   DB_HOST=localhost
   DB_PORT=3306
   DB_USER=root
   DB_PASSWORD=your_password
   DB_NAME=birthday_db
   ```
4. Start the backend:
   ```bash
   npm start
   ```

The API will be available at:
- http://localhost:3000/api/birthday
- http://localhost:3000/health

## Frontend Setup

1. Open the frontend files in a browser or serve them using a web server.
2. Ensure the backend API is available at `/api/birthday`.

## Database Setup

Run the SQL script in the database folder to create the required table and sample data.

## Terraform Setup

1. Navigate to the terraform folder:
   ```bash
   cd terraform
   ```
2. Initialize Terraform:
   ```bash
   terraform init
   ```
3. Review and apply the infrastructure changes:
   ```bash
   terraform plan
   terraform apply
   ```

## Docker (Optional)

The repository includes Dockerfiles for both backend and frontend, which can be used to containerize the application.

## Notes

- Terraform provider downloads and local state files are ignored by Git to avoid pushing large artifacts.
- The GitHub Actions workflow in `.github/workflows/terraform.yaml` automates Terraform deployment when changes are pushed under the terraform directory.   
