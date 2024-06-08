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

        stage('Login in Dockerhub ') {
            steps {
                // Authenticate with Docker Hub
                withCredentials([usernamePassword(credentialsId: DOCKER_REGISTRY_CREDENTIALS_ID, usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]){

                // Log in to Docker Hub
                    sh "/usr/local/bin/docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD}"

                 }
                 }
                 }

        
        stage('Build Docker Image') {
            steps {
                script {
                    docker.withRegistry('','dockerhub') {
                        docker_image = docker.build "${IMAGE_NAME}"
                    }
                        docker.withRegistry('','dockerhub') {
                        docker_image.push("${IMAGE_TAG}")
                        docker_image.push('latest')
                      
                     }
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
