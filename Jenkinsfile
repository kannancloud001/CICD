pipeline {
    agent {
        label 'docker' // Ensure Jenkins runs this on an agent with Docker installed
    }
    environment {
        DOCKER_IMAGE = "kannandolmites/nginx-frontend" // Replace with your Docker image name
        DOCKER_TAG = "latest" // Update if you want a specific version tag
        KUBE_DEPLOY_FILE = "deployment-and-service.yml" // Kubernetes manifest file
    }
    stages {
        stage('Checkout') {
            steps {
                echo "Checking out the repository..."
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/kannancloud001/CICD.git']])
            }
        }
        stage('Build Docker Image') {
            steps {
                echo "Building the Docker image..."
                script {
                    docker.build("${DOCKER_IMAGE}:${DOCKER_TAG}")
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                echo "Pushing the Docker image to the registry..."
                script {
                    withDockerRegistry([credentialsId: 'docker-hub-credentials', url: '']) {
                        docker.image("${DOCKER_IMAGE}:${DOCKER_TAG}").push()
                    }
                }
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                echo "Deploying to Kubernetes cluster..."
                script {
                    sh '''
                    kubectl apply -f ${KUBE_DEPLOY_FILE}
                    '''
                }
            }
        }
    }
    post {
        always {
            echo "Pipeline execution completed."
        }
        success {
            echo "Pipeline executed successfully!"
        }
        failure {
            echo "Pipeline failed. Check logs for more details."
        }
    }
}
