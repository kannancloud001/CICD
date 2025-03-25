pipeline {
    agent any
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
        stage('Build and Push Docker Image') {
            steps {
                echo "Building and pushing the Docker image..."
                sh """
                docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} .
                docker login -u $DOCKER_USER -p $DOCKER_PASS
                docker push ${DOCKER_IMAGE}:${DOCKER_TAG}
                """
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                echo "Deploying to Kubernetes..."
                sh """
                kubectl apply -f ${KUBE_DEPLOY_FILE}
                """
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
