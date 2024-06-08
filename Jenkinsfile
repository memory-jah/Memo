pipeline {
    agent any

    environment {
        GIT_CREDENTIALS_ID = 'project1' // Replace with your GitHub credentials ID
        DOCKER_REGISTRY_CREDENTIALS_ID = 'dockerhub' // Replace with your Docker Hub credentials ID
        DOCKER_IMAGE = 'memoryjah/exercice:python' // Replace with your Docker image details
        REPOSITORY_URL = 'https://github.com/memory-jah/Memo.git' // Replace with your repository URL
        BRANCH_NAME = 'main' // Replace with the branch name you want to clone
    }

    stages {
        stage('Clone Repository') {
            steps {
                // Checkout code from GitHub repository
                git credentialsId: "${GIT_CREDENTIALS_ID}", url: "${REPOSITORY_URL}", branch: "${BRANCH_NAME}"
            }
        }

        stage('Login to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('', "${DOCKER_REGISTRY_CREDENTIALS_ID}") {
                        // Docker login is handled automatically by withRegistry
                    }
                }
            }
        }

        stage('Pull Docker Image') {
            steps {
                script {
                    sh "docker pull ${DOCKER_IMAGE}"
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("${DOCKER_IMAGE}")
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    // Stop and remove any running container with the same name
                    sh """
                    if [ \$(docker ps -q -f name=your-container-name) ]; then
                        docker stop your-container-name
                        docker rm your-container-name
                    fi
                    """
                    // Run the Docker container
                    sh "docker run -d -p 8000:8000 --name your-container-name ${DOCKER_IMAGE}"
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('', "${DOCKER_REGISTRY_CREDENTIALS_ID}") {
                        dockerImage.push()
                    }
                }
            }
        }
    }
}
