pipeline {
    agent {
        docker {image 'ubuntu'}
    }
    environment {
        GIT_CREDENTIALS_ID = 'github' // Replace with your SSH credentials ID for GitHub
        DOCKER_REGISTRY_CREDENTIALS_ID = 'dockerhub' // Replace with your Docker Hub credentials ID
        DOCKER_IMAGE = 'memoryjah/exercice' // Replace with your Docker image name
        REPOSITORY_URL = 'https://github.com/memory-jah/Memo.git' // Replace with your repository URL
        BRANCH_NAME = 'main' // Replace with the branch name you want to clone
    }

    stages {
        stage('Clone Repository') {
            steps {
                // Checkout code from GitHub repository using SSH
                git credentialsId: "${GIT_CREDENTIALS_ID}", url: "${REPOSITORY_URL}", branch: "${BRANCH_NAME}"
            }
        }

       

        
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${DOCKER_IMAGE}:project24-${env.BUILD_NUMBER}")
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    // Stop and remove any running container with the same name
                    sh '''
                    if [ $(docker ps -q -f name=project24-${env.BUILD_NUMBER}) ]; then
                        docker stop project24-${env.BUILD_NUMBER}
                        docker rm project24-${env.BUILD_NUMBER}
                    fi
                    '''
                    // Run the Docker container
                    docker.image("${DOCKER_IMAGE}:project24-${env.BUILD_NUMBER}").run("--name project24-${env.BUILD_NUMBER}")
                }
            }
        }

           
        stage('docker push Image') {
            steps {
                script {
                     // Login to Docker Hub
                    sh "echo $DOCKER_REGISTRY_CREDENTIALS_ID | docker login -u ${env.DOCKER_USERNAME} --password-stdin"

                    // Push the Docker image
                    sh "docker push ${DOCKER_IMAGE}:project24-${env.BUILD_NUMBER}"
                    sh "docker push ${DOCKER_IMAGE}:latest"
                    
                }
           }


   
        }
    }
    }
