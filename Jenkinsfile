pipeline {
    agent any
    tools {
        nodejs 'Node20'
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
                    sh 'npm install eslint eslint-plugin-security eslint-formatter-unix --save-dev'
                    sh 'npx eslint server.js --format eslint-formatter-unix --output-file eslint-report.txt --config eslint.config.js || true'
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
