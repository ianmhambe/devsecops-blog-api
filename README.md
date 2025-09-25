# DevSecOps Blog API
A Node.js REST API for a blog, demonstrating DevSecOps with Jenkins, Docker, and AWS ECS.

## Project Structure
- `app/`: Node.js (Express) API code.
  - `eslint.config.js`: ESLint configuration for security-focused static analysis.
- `infra/`: Terraform scripts for AWS ECS.
- `Dockerfile`: Containerizes the app using `node:20-slim`, runs as non-root user.
- `Jenkinsfile`: Defines the CI/CD pipeline with ESLint (SAST), npm audit (dependency scan), and Trivy (container scan).

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
- Configured and ran Jenkins pipeline with ESLint, npm audit, and Trivy scans.

## Known Issues
- **Trivy Scan Findings**:
  - **libpam-modules, libpam-modules-bin, libpam-runtime, libpam0g**: CVE-2025-6020 (HIGH, no fix available). Directory traversal vulnerability in Linux-PAM.
  - **zlib1g**: CVE-2023-45853 (CRITICAL, will_not_fix). Integer overflow in zipOpenNewFileInZip4_6.
  - These will be monitored for updates in future pipeline runs.
