# RAG-Based Chatbot for Research Accessibility

This project provides a Retrieval-Augmented Generation (RAG)-based chatbot designed to improve research accessibility using a combination of **Ruby on Rails** for the frontend and **FastAPI** for the backend, powered by **OpenAI GPT-3.5 Turbo** and **PostgreSQL** as the database.

## Prerequisites

- Docker and Docker Compose installed on your system.
- OpenAI API Key (You can sign up and get one [here](https://platform.openai.com/)).

## Project Structure

- `rails/` - Contains the Ruby on Rails front-end application.
- `Ragbot_api/` - FastAPI-based backend handling the RAG model processing.
- `.env` - Environment variables, including the OpenAI API key and database details.

## Services Overview

- **Rails**: Ruby on Rails 7 app for user interaction (upload documents, query chatbot).
- **FastAPI**: Backend that handles text extraction, processing, and query-response generation using OpenAI GPT-3.5 Turbo.
- **PostgreSQL**: Database to store user sessions, uploaded documents, and related metadata.

## Setup and Run Instructions

### 1. Clone the Repository

```bash
git clone <your-repo-url>
cd <your-project-directory>
```

### 2. Environment Setup
Create a .env file in the root of the project. This file is used to configure environment variables for both Rails and FastAPI services. Here’s an example .env file setup:
```bash
# .env for Rails and FastAPI services
RAILS_ENV=development
DATABASE_URL=postgres://postgres:password@db:5432/myapp_development

# OpenAI API Key for FastAPI
OPENAI_API_KEY=your-openai-api-key
```
Replace your-openai-api-key with the actual key you get from OpenAI.

### 3. Build and Run Docker Containers
To run the services, use Docker Compose. This will spin up all the necessary containers for Rails, FastAPI, and PostgreSQL.
```bash
docker-compose up --build
```
This command will:

- Build the Rails app and start it on port 3000.
- Build and start the FastAPI backend on port 8000.
- Start the PostgreSQL database.
You can access the Rails app at `http://localhost:3000` and the FastAPI service at `http://localhost:8000`.

### 4. Running Database Migrations
Once the containers are up, you need to run the Rails database migrations to set up the schema.
```bash
docker-compose exec rails bash
bundle exec rails db:create
bundle exec rails db:migrate
```
This will create the necessary database tables in PostgreSQL for the Rails application.
### 5. Adding OpenAI API Key
Ensure that the OpenAI API key is included in the FastAPI service by placing it in the `Ragbot_api/.env` file. If using Docker, this key should be already mapped from the root `.env` file.

### 6. Testing the Setup
- Visit `http://localhost:3000` to interact with the web interface.
- Upload research papers and start a new chat session with the chatbot.
- The chatbot will query the backend FastAPI service to retrieve relevant answers based on your documents.
## Additional Commands
### Stopping the Services
To stop all the services, press `CTRL+C` or run:
```bash
docker-compose down
```
### Rebuild Containers
If you make changes to the code, you can rebuild the Docker images:
```bash
docker-compose up --build
```
### Logs and Debugging
You can view the logs of individual services:
```bash
docker-compose logs rails
docker-compose logs fastapi
```
