pipeline {
    agent any
    tools {
        nodejs 'Node20' // Matches the name set in Global Tool Configuration
    }
    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/ianmhambe/devsecops-blog-api.git', branch: 'master'
            }
        }
        stage('Install Dependencies') {
            steps {
                dir('app') {
                    sh 'npm install'
                }
            }
        }
        stage('SAST with ESLint') {
            steps {
                dir('app') {
                    sh 'npm install eslint eslint-plugin-security --save-dev'
                    sh 'npx eslint server.js --format unix --output-file eslint-report.txt || true'
                }
            }
        }
        stage('Dependency Scan with npm audit') {
            steps {
                dir('app') {
                    sh 'npm audit --audit-level=high || true'
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t blog-api .'
            }
        }
        stage('Container Scan with Trivy') {
            steps {
                sh 'docker run --rm aquasec/trivy:latest image --severity CRITICAL,HIGH blog-api || true'
            }
        }
    }
    post {
        always {
            archiveArtifacts artifacts: 'app/eslint-report.txt', allowEmptyArchive: true
        }
    }
}
