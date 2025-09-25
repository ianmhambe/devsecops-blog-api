# DevSecOps Blog API
A Node.js REST API for a blog, demonstrating DevSecOps with Jenkins, Docker, and AWS ECS.

## Project Structure
- `app/`: Node.js (Express) API code.
- `infra/`: Terraform scripts for AWS ECS.
- `Dockerfile`: Containerizes the app using `node:20-slim`, runs as non-root user.
- `Jenkinsfile`: Defines the CI/CD pipeline with security scans.

## API Endpoints
- `POST /posts`: Create a post (requires `title` and `content`).
- `GET /posts`: List all posts.
- `GET /posts/:id`: Get a post by ID.
- `PUT /posts/:id`: Update a post.
- `DELETE /posts/:id`: Delete a post.

## Status
- Set up repository and Jenkins.
- Built and tested Node.js blog API locally.
- Containerized the app with Docker and tested locally.
