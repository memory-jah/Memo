pipeline {
    agent any
    
    environment {
        GIT_CREDENTIALS_ID = 'project1' // Replace with your GitHub credentials ID
        DOCKER_REGISTRY_CREDENTIALS_ID = 'dockerhub' // Replace with your Docker Hub credentials ID
        DOCKER_IMAGE = 'memoryjah/exercice:python' // Replace with your Docker image
    }
    
    stages {
        stage('Clone Repository') {
            steps {
                // Checkout code from GitHub repository
                git credentialsId: GIT_CREDENTIALS_ID, url: 'https://github.com/memory-jah/Memo.git', branch: 'main'
            }
        }
           
        stage('Login to Docker Hub') {
            steps {
                // Authenticate with Docker Hub
                withCredentials([usernamePassword(credentialsId: DOCKER_REGISTRY_CREDENTIALS_ID, usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                    // Log in to Docker Hub using --password-stdin for security
                    sh "echo ${DOCKER_PASSWORD} | docker login -u ${DOCKER_USERNAME} --password-stdin"
                }
            }
        }
        
        stage('Pull the private Docker Image') {
            steps {
                // Pull the private Docker image
                sh "docker pull ${DOCKER_IMAGE}"
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("${DOCKER_IMAGE}")
                }
            }
        }

        stage('Deploy Docker Container') {
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
    }
}
