pipeline {
    agent any

    environment {
        GIT_CREDENTIALS_ID = 'github' // Replace with your SSH credentials ID for GitHub
        DOCKER_REGISTRY_CREDENTIALS_ID = 'dockerhub' // Replace with your Docker Hub credentials ID
        DOCKER_IMAGE = 'project24' // Replace with your Docker image name
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
                    docker.build("${DOCKER_IMAGE}:${env.BUILD_NUMBER}")
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    // Stop and remove any running container with the same name
                    sh '''
                    if [ $(docker ps -q -f name=${DOCKER_IMAGE}_${env.BUILD_NUMBER}) ]; then
                        docker stop ${DOCKER_IMAGE}_${env.BUILD_NUMBER}
                        docker rm ${DOCKER_IMAGE}_${env.BUILD_NUMBER}
                    fi
                    '''
                    // Run the Docker container
                    docker.image("${DOCKER_IMAGE}:${env.BUILD_NUMBER}").run("--name ${DOCKER_IMAGE}_${env.BUILD_NUMBER}")
                }
            }
        }

           
        stage('Build Docker Image') {
            steps {
                script {
                     docker.withRegistry('','dockerhub') {
                        docker_image.push("${DOCKER_IMAGE}")
                        docker_image.push('latest')
       
                    }
                }
           }


    post {
        always {
            script {
                // Clean up the Docker image
                try {
                    docker.image("${DOCKER_IMAGE}:${env.BUILD_NUMBER}").remove()
                } catch (Exception e) {
                    echo "Failed to remove Docker image: ${e}"
                }
            }
        }
    }
}
